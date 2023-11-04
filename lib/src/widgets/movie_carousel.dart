import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/providers/movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class MovieCarouselWidget extends StatelessWidget {
  final String contentType;
  const MovieCarouselWidget(this.contentType, {super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = context.read<MovieProvider>();

    return FutureBuilder<List<Map<String, dynamic>>?>(
        future: movieProvider.fetchMovies(contentType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('Cast is not available.');
          } else {
            List<Map<String, dynamic>>? data = snapshot.data;

            print(data);
            if (data != null) {
              final limitedMovies = data.take(10).toList();

              return Container(
                  child: FlutterCarousel(
                options: CarouselOptions(
                  height: 590,
                  viewportFraction: 1.0,
                  showIndicator: true,
                  slideIndicator: const CircularSlideIndicator(
                      padding: EdgeInsets.only(bottom: 40),
                      currentIndicatorColor: Colors.white,
                      indicatorBorderColor: Color.fromARGB(255, 255, 255, 255),
                      indicatorBorderWidth: 1,
                      indicatorRadius: 5),
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 6),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.easeInOut,
                ),
                items: limitedMovies.map((movieMap) {
                  final posterPath = movieMap['poster_path'];
                  return GestureDetector(
                    onTap: () {
                      final movieId = movieMap['id'];
                      String mediaType = '';
                      if (movieMap.containsKey('title')) {
                        mediaType = 'movie';
                      }
                      if (movieMap.containsKey('name')) {
                        mediaType = 'tv';
                      }
                      Navigator.pushNamed(context, '/details', arguments: {
                        'mediaType': mediaType,
                        'movieId': movieId
                      });
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500/$posterPath',
                        fit: BoxFit.cover,
                        height: 590,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  );
                }).toList(),
              ));
            } else {
              return Container();
            }
          }
        });
  }
}
