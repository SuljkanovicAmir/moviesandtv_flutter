import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moviesandtv_flutter/src/providers/upcoming_movies_provider.dart';
import 'package:provider/provider.dart';

class UpcomingMoviesWidget extends StatelessWidget {
  const UpcomingMoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final upcomingMoviesProvider = Provider.of<UpcomingMoviesProvider>(context);

    if (upcomingMoviesProvider.upcomingMovies.isEmpty) {
      upcomingMoviesProvider.fetchMovies();

      return Container(height: 500, color: Colors.black);
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
                'Upcoming movies',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: upcomingMoviesProvider.upcomingMovies.length,
                itemBuilder: (context, index) {
                  final movie = upcomingMoviesProvider.upcomingMovies[index];
                  final backdropPath = movie['backdrop_path'];
                  final releaseDate = movie['release_date'];
                  final parsedDate = DateTime.parse(releaseDate);
                  final formattedDate =
                      DateFormat('dd.MM.yyyy').format(parsedDate);
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
                                  child: Text(
                                    movie['title'],
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 212, 212, 212),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 220,
                                  padding:
                                      const EdgeInsets.only(top: 0, left: 5),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Release date: $formattedDate',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 146, 146, 146),
                                    ),
                                  ),
                                ),
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
