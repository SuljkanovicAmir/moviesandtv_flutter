import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import 'package:moviesandtv_flutter/src/providers/filter_content_provider.dart';
import 'package:provider/provider.dart';
import 'package:moviesandtv_flutter/utils/api_constants.dart';

class GenredWidget extends StatelessWidget {
  final String contentType;
  final String selectedGenreValue;

  const GenredWidget(this.contentType, this.selectedGenreValue, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredProvider = Provider.of<FilterContentProvider>(context);

    return FutureBuilder<List<MovieModel>?>(
      future:
          filteredProvider.getFilteredContent(contentType, selectedGenreValue),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return SizedBox(
            height: MediaQuery.of(context).size.height < 500
                ? MediaQuery.of(context).size.height - 180
                : null,
            child: const Center(child: Text('No data')),
          );
        } else {
          return Container(
            padding: const EdgeInsets.only(bottom: 50),
            child: GridView.count(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              childAspectRatio: 0.7,
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List<Widget>.generate(
                snapshot.data!.length,
                (index) {
                  final content = snapshot.data![index];
                  final posterPath = content.posterPath;
                  if (posterPath.isNotEmpty) {
                    return GestureDetector(
                      onTap: () {
                        final movieId = content.id;
                        String mediaType =
                            content.title.isNotEmpty ? 'movie' : 'tv';

                        Navigator.pushNamed(context, '/details', arguments: {
                          'mediaType': mediaType,
                          'movieId': movieId,
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 1,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: '${ApiConstants.BASE_IMAGE_URL}$posterPath',
                          width: double.infinity,
                          fit: BoxFit.fitHeight,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(160, 255, 255, 255),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return Container(
                    color: const Color.fromARGB(0, 0, 0, 0),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
