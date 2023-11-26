import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import 'package:moviesandtv_flutter/src/providers/popular_movies_provider.dart';
import 'package:provider/provider.dart';
import 'package:moviesandtv_flutter/utils/api_constants.dart';

class PopularMoviesWidget extends StatelessWidget {
  const PopularMoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final popularMoviesProvider =
        Provider.of<PopularMoviesProvider>(context, listen: false);

    return FutureBuilder<List<MovieModel>?>(
      future: popularMoviesProvider.getPopularMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No popular movies available.'));
        } else {
          List<MovieModel>? data = snapshot.data!;

          return SizedBox(
            height: 280,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  color: const Color.fromARGB(0, 255, 255, 255),
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: const Text(
                    'Popular Movies',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final movie = data[index];
                      final backdropPath = movie.backdropPath;
                      final voteAverage = movie.voteAverage;

                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/details',
                            arguments: {
                              'mediaType': 'movie',
                              'movieId': movie.id,
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 10,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 220,
                                height: 130,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '${ApiConstants.BASE_IMAGE_URL}$backdropPath',
                                  placeholder: (context, url) => Center(
                                    child: Container(
                                      color: const Color.fromARGB(133, 49, 49, 49),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Container(
                                width: 220,
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 5,
                                ),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star_rate_rounded,
                                      color: Color.fromARGB(255, 165, 118, 15),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      ('$voteAverage/10 '),
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 212, 212, 212),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
