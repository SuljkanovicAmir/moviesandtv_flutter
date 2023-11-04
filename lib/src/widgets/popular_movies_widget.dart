import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/providers/popular_movies_provider.dart';
import 'package:provider/provider.dart';

class PopularMoviesWidget extends StatelessWidget {
  const PopularMoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final popularMoviesProvider = Provider.of<PopularMoviesProvider>(context);

    if (popularMoviesProvider.popularMovies.isEmpty) {
      popularMoviesProvider.fetchMovies();
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
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
                itemCount: popularMoviesProvider.popularMovies.length,
                itemBuilder: (context, index) {
                  final movie = popularMoviesProvider.popularMovies[index];
                  final backdropPath = movie['backdrop_path'];
                  final voteAverage = movie['vote_average'].toStringAsFixed(1);

                  if (backdropPath != null) {
                    return GestureDetector(
                        onTap: () {
                          final movieId = movie['id'];
                          String mediaType = 'movie';
                          Navigator.pushNamed(context, '/details', arguments: {
                            'mediaType': mediaType,
                            'movieId': movieId
                          });
                        },
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 10), // Adjust the spacing
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 220,
                                  height: 130,
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/w500/$backdropPath',
                                    fit: BoxFit
                                        .contain, // Ensure the image fits within the container
                                  ),
                                ),
                                Container(
                                    width: 220,
                                    padding:
                                        const EdgeInsets.only(top: 10, left: 5),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star_rate_rounded,
                                          color:
                                              Color.fromARGB(255, 165, 118, 15),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          ('$voteAverage/10 '),
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 212, 212, 212),
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            )));
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
