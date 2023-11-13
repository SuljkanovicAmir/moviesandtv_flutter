import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import 'package:moviesandtv_flutter/src/providers/upcoming_movies_provider.dart';
import 'package:provider/provider.dart';
import 'package:moviesandtv_flutter/utils/api_constants.dart';

class UpcomingMoviesWidget extends StatelessWidget {
  const UpcomingMoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final upcomingMoviesProvider = context.read<UpcomingMoviesProvider>();

    return FutureBuilder<List<MovieModel>?>(
      future: upcomingMoviesProvider.getUpcomingMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(height: 500, color: Colors.black);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Container(height: 500, color: Colors.black);
        } else {
          List<MovieModel>? data = snapshot.data;
          return SizedBox(
            height: 280,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  color: const Color.fromARGB(0, 255, 255, 255),
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                  child: const Text(
                    'Upcoming Movies',
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
                      final backdropPath = movie.backdropPath;
                      final releaseDate = movie.releaseDate;
                      final parsedDate = DateTime.parse(releaseDate);
                      final formattedDate =
                          DateFormat('dd.MM.yyyy').format(parsedDate);
                      if (backdropPath.isNotEmpty) {
                        return GestureDetector(
                          onTap: () {
                            final movieId = movie.id;
                            String mediaType = 'movie';
                            Navigator.pushNamed(
                              context,
                              '/details',
                              arguments: {
                                'mediaType': mediaType,
                                'movieId': movieId,
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
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        color:
                                            Color.fromARGB(160, 255, 255, 255),
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
                                  child: Text(
                                    movie.title,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 212, 212, 212),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 220,
                                  padding: const EdgeInsets.only(
                                    top: 0,
                                    left: 5,
                                  ),
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
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
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
