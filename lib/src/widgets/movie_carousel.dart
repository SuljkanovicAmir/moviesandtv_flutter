import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import 'package:moviesandtv_flutter/src/providers/movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:moviesandtv_flutter/utils/api_constants.dart';

class MovieCarouselWidget extends StatelessWidget {
  final String contentType;
  const MovieCarouselWidget(this.contentType, {super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = context.read<MovieProvider>();
    return FutureBuilder<List<MovieModel>?>(
        future: movieProvider.getContentCarousel(contentType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('Cast is not available.');
          } else {
            List<MovieModel>? data = snapshot.data;
            if (data != null) {
              final limitedMovies = data.take(10).toList();

              return Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: FlutterCarousel(
                    options: CarouselOptions(
                      height: 590,
                      viewportFraction: 1.0,
                      showIndicator: true,
                      slideIndicator: const CircularSlideIndicator(
                          padding: EdgeInsets.only(bottom: 30),
                          currentIndicatorColor: Colors.white,
                          indicatorBorderColor:
                              Color.fromARGB(255, 255, 255, 255),
                          indicatorBorderWidth: 1,
                          indicatorRadius: 5),
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 6),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.easeInOut,
                    ),
                    items: limitedMovies.map((movie) {
                      final posterPath = movie.posterPath;
                      return GestureDetector(
                        onTap: () {
                          final movieId = movie.id;
                          String mediaType = '';
                          if (movie.title.isNotEmpty) {
                            mediaType = 'movie';
                          } else {
                            mediaType = 'tv';
                          }
                          Navigator.pushNamed(context, '/details', arguments: {
                            'mediaType': mediaType,
                            'movieId': movieId
                          });
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl:
                                '${ApiConstants.BASE_IMAGE_URL}$posterPath',
                            fit: BoxFit.cover,
                            height: 590,
                            fadeInDuration: const Duration(milliseconds: 500),
                            width: MediaQuery.of(context).size.width,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                  color: Color.fromARGB(160, 255, 255, 255)),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
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
