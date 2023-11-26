import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import 'package:moviesandtv_flutter/utils/api_constants.dart';

class SimilarContentWidget extends StatelessWidget {
  final String mediaType;
  final String movieId;
  final Future<List<MovieModel>?> getSimilar;

  const SimilarContentWidget(this.mediaType, this.movieId, this.getSimilar,
      {super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>?>(
        future: getSimilar,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('No similar content available.');
          } else {
            List<MovieModel>? data = snapshot.data;
            return SizedBox(
              height: 300,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.transparent,
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: const Text(
                      'Similar',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        final movie = data[index];
                        final posterPath = movie.posterPath;
                        if (posterPath.isNotEmpty) {
                          return GestureDetector(
                              onTap: () {
                                final movieId = movie.id;
                                String mediaType = '';
                                if (movie.title.isNotEmpty) {
                                  mediaType = 'movie';
                                } else {
                                  mediaType = 'tv';
                                }
                                Navigator.pushNamed(context, '/details',
                                    arguments: {
                                      'mediaType': mediaType,
                                      'movieId': movieId
                                    });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                child: SizedBox(
                                  height: 250,
                                  width: 170,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${ApiConstants.BASE_IMAGE_URL}$posterPath',
                                    placeholder: (context, url) => Center(
                                      child: Container(
                                        color: const Color.fromARGB(133, 49, 49, 49),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ));
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
