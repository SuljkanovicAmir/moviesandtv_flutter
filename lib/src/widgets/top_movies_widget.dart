import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/providers/top_movies_provider.dart';
import 'package:provider/provider.dart';

class TopMoviesWidget extends StatelessWidget {
  const TopMoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final topMoviesProvider = Provider.of<TopMoviesProvider>(context);

    if (topMoviesProvider.topMovies.isEmpty) {
      topMoviesProvider.fetchMovies();
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SizedBox(
        height: 330,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              color: Colors.transparent,
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: const Text(
                'Top Rated Movies 2023',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topMoviesProvider.topMovies.length,
                itemBuilder: (context, index) {
                  final movie = topMoviesProvider.topMovies[index];
                  final posterPath = movie['poster_path'];

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
                            vertical: 0, horizontal: 10), // Adjust the spacing
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500/$posterPath',
                          width: 170, // Set the desired width for each poster
                          fit: BoxFit.contain,
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
