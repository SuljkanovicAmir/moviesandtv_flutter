import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import 'package:moviesandtv_flutter/src/models/movie_details_model.dart';
import 'package:moviesandtv_flutter/src/providers/cast_provider.dart';
import 'package:moviesandtv_flutter/src/providers/similar_content_provide.dart';
import 'package:moviesandtv_flutter/src/providers/video_provider.dart';
import 'package:moviesandtv_flutter/src/widgets/cast_widget.dart';
import 'package:moviesandtv_flutter/src/widgets/floating_button.dart';
import 'package:moviesandtv_flutter/src/widgets/similar_content_widget.dart';
import 'package:provider/provider.dart';
import 'package:moviesandtv_flutter/utils/api_constants.dart';

class MyDetailsWidget extends StatelessWidget {
  final Future<MovieDetailModel?> fetchDetails;
  final String mediaType;
  final String movieId;

  const MyDetailsWidget(this.mediaType, this.fetchDetails, this.movieId,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final similarContentProvider = context.read<SimilarContentProvider>();
    final castProvider = context.read<CastProvider>();
    final videoProvider = context.read<VideoProvider>();

    Future<List<MovieModel>?> getSimilar =
        similarContentProvider.getSimilarContent(mediaType, movieId);
    Future<Map<String, dynamic>?> fetchCast =
        castProvider.fetchCast(mediaType, movieId);
    Future<Map<String, dynamic>?> fetchVideo =
        videoProvider.fetchVideo(movieId);

    return FutureBuilder<MovieDetailModel?>(
        future: fetchDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
                height: MediaQuery.of(context).size.height * 2,
                child: const Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('No similar content available.');
          } else {
            MovieDetailModel? data = snapshot.data;

            final name = data?.title ?? '';
            final runtime = data?.runtime ?? '';

            return Stack(children: [
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 50),
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SizedBox(
                              child: Stack(
                            children: [
                              data?.backdropPath != null
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          '${ApiConstants.BASE_IMAGE_URL}${data?.backdropPath}',
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      placeholder: (context, url) => Center(
                                        child: Container(
                                          color: const Color.fromARGB(
                                              218, 92, 92, 92),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )
                                  : const Icon(
                                      Icons.not_interested_sharp,
                                      size: 100,
                                      color: Colors.grey,
                                    ),
                              Positioned.fill(
                                child: IgnorePointer(
                                  ignoring: true,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromRGBO(0, 0, 0, 0.400),
                                          Color.fromRGBO(0, 0, 0, 0.400),
                                        ],
                                        stops: [0.1, 1],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                          SizedBox(
                              height: 230,
                              width: MediaQuery.sizeOf(context).width,
                              child: Center(
                                child: GestureDetector(
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.play_circle,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Watch Trailer',
                                          style: TextStyle(
                                              height: 1, color: Colors.white),
                                        )
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(context, '/trailer',
                                          arguments: {
                                            'fetchVideo': fetchVideo
                                          });
                                    }),
                              )),
                          Positioned(
                            left: 0,
                            bottom: -90,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              height: 180,
                              width: 120,
                              child: data?.posterPath != null
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          '${ApiConstants.BASE_IMAGE_POSTER_URL}${data?.posterPath}',
                                      fit: BoxFit.fitWidth,
                                      placeholder: (context, url) => Center(
                                        child: Container(
                                          color: const Color.fromARGB(
                                              255, 39, 39, 39),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )
                                  : const Icon(
                                      Icons.not_interested_sharp,
                                      size: 100,
                                      color: Colors.grey,
                                    ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 140),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.fromLTRB(15, 8, 10, 2),
                              child: SelectableText(
                                data?.title ?? '',
                                style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    height: 1.2,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          offset: Offset(1.2, 0))
                                    ],
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  const Icon(
                                    Icons.star_rate_rounded,
                                    color: Color.fromARGB(255, 204, 149, 32),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    ('${data?.voteAverage}/10 '),
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 212, 212, 212),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 2),
                              child: Row(
                                children: [
                                  if (mediaType == 'tv')
                                    Text(
                                      data?.networkName ?? '',
                                      style: const TextStyle(
                                          color: Color(0xFFB4B4B4),
                                          fontSize: 12),
                                    )
                                  else
                                    Text(
                                      '${data?.runtime} MIN',
                                      style: const TextStyle(
                                          color: Color(0xFFB4B4B4),
                                          fontSize: 12),
                                    ),
                                  const SizedBox(width: 10),
                                  Text(
                                    data?.releaseDate ?? '',
                                    style: const TextStyle(
                                        color: Color(0xFFB4B4B4), fontSize: 12),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    data?.genres ?? '',
                                    style: const TextStyle(
                                        color: Color(0xFFB4B4B4), fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 40, 0, 10),
                        child: const Text(
                          'Overview',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: SelectableText(
                          data?.overview?.trim().isEmpty ?? true
                              ? 'No details'
                              : data!.overview!,
                          style: const TextStyle(
                              color: Color.fromARGB(230, 255, 255, 255)),
                        ),
                      ),
                      ExpandableContainer(mediaType, movieId, fetchCast),
                      SimilarContentWidget(mediaType, movieId, getSimilar),
                    ],
                  ),
                ),
              ),
              FloatingButtonWidget(
                  name: name,
                  runtime: runtime,
                  movieId: movieId,
                  mediaType: mediaType),
            ]);
          }
        });
  }
}
