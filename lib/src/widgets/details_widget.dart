import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import 'package:moviesandtv_flutter/src/models/movie_details_model.dart';
import 'package:moviesandtv_flutter/src/providers/cast_provider.dart';
import 'package:moviesandtv_flutter/src/providers/similar_content_provide.dart';
import 'package:moviesandtv_flutter/src/providers/video_provider.dart';
import 'package:moviesandtv_flutter/src/widgets/favorites_button.dart';
import 'package:moviesandtv_flutter/src/widgets/cast_widget.dart';
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

            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(bottom: 100),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF000000),
                      Color(0xFF000000),
                      Color(0xFF000000),
                      Color(0xFF000000),
                      Color(0xFF000000),
                      Color(0xFF000000),
                      Color.fromARGB(255, 1, 3, 7),
                      Color.fromARGB(255, 3, 10, 20),
                      Color.fromARGB(255, 3, 14, 31),
                      Color(0xFF041125),
                      Color(0xFF041125),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 600,
                          child: MediaQuery.of(context).size.width > 500
                              ? data?.backdropPath != null
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          '${ApiConstants.BASE_IMAGE_BACKDROP_URL}${data?.backdropPath}',
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(
                                          color: Color.fromARGB(
                                              131, 255, 255, 255),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )
                                  : const Icon(
                                      Icons.not_interested_sharp,
                                      size: 100,
                                      color: Colors.grey,
                                    )
                              : data?.posterPath != null
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          '${ApiConstants.BASE_IMAGE_URL}${data?.posterPath}',
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      placeholder: (context, url) => Center(
                                        child: Container(
                                          color:
                                              const Color.fromARGB(133, 49, 49, 49),
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
                        Positioned.fill(
                          bottom: -5,
                          child: IgnorePointer(
                            ignoring: true,
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromRGBO(0, 0, 0, 0),
                                    Color.fromRGBO(0, 0, 0, 0.623),
                                    Color.fromRGBO(0, 0, 0, 1),
                                  ],
                                  stops: [0.60, 0.70, 0.80],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: -12,
                            left: 0,
                            right: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 5, 5, 5),
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.sizeOf(context).width *
                                              0.8),
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
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 0),
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
                                            color: Color(0xFFB4B4B4),
                                            fontSize: 12),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        data?.genres ?? '',
                                        style: const TextStyle(
                                            color: Color(0xFFB4B4B4),
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/trailer', arguments: {
                                            'fetchVideo': fetchVideo
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.play_circle_outline,
                                          color: Colors.white,
                                          size: 60,
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            FavoriteButton(
                                                movieId: movieId, mediaType),
                                            const SizedBox(width: 15),
                                            const Icon(
                                              Icons.file_download_rounded,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_rate_rounded,
                            color: Color.fromARGB(255, 204, 149, 32),
                          ),
                          const SizedBox(width: 5),
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
                          horizontal: 20, vertical: 10),
                      child: SelectableText(
                        data?.overview ?? 'No details',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    ExpandableContainer(mediaType, movieId, fetchCast),
                    SimilarContentWidget(mediaType, movieId, getSimilar)
                  ],
                ),
              ),
            );
          }
        });
  }
}
