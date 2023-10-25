import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/providers/movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class MovieCarouselWidget extends StatelessWidget {
  const MovieCarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    if (movieProvider.movies.isEmpty) {
      movieProvider.fetchMovies();

      return Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(),
          ));
    } else {
      final limitedMovies = movieProvider.movies.take(10).toList();

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

                if (movieMap['title'] == true) {
                  mediaType = 'movie';
                } else {
                  mediaType = 'tv';
                }
                Navigator.pushNamed(context, '/details',
                    arguments: {'mediaType': mediaType, 'movieId': movieId});
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
        ),
      );
    }
  }
}
