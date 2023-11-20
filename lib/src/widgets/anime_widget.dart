import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import 'package:moviesandtv_flutter/src/providers/anime_provider.dart';
import 'package:provider/provider.dart';
import 'package:moviesandtv_flutter/utils/api_constants.dart';

class AnimeWidget extends StatelessWidget {
  const AnimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final animeProvider = context.read<AnimeProvider>();

    return FutureBuilder<List<MovieModel>?>(
      future: animeProvider.getTopRatedAnimeTVShows(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(height: 500, color: Colors.black);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<MovieModel>? data = snapshot.data;
          return SizedBox(
            height: 330,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.transparent,
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: const Text(
                    'Top Picks: Anime Series (2010-2020)',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      final movie = data[index];
                      final posterPath = movie.posterPath;

                      return GestureDetector(
                        onTap: () {
                          final movieId = movie.id;
                          String mediaType = 'tv';
                          Navigator.pushNamed(context, '/details', arguments: {
                            'mediaType': mediaType,
                            'movieId': movieId
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          child: CachedNetworkImage(
                            imageUrl:
                                '${ApiConstants.BASE_IMAGE_URL}$posterPath',
                            width: 170,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: Color.fromARGB(160, 255, 255, 255),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
