import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/providers/cast_provider.dart';
import 'package:moviesandtv_flutter/src/providers/similar_content_provide.dart';
import 'package:moviesandtv_flutter/src/providers/video_provider.dart';
import 'package:moviesandtv_flutter/src/widgets/cast_widget.dart';
import 'package:moviesandtv_flutter/src/widgets/similar_content_widget.dart';
import 'package:provider/provider.dart';

class MyDetailsWidget extends StatelessWidget {
  final Future<Map<String, dynamic>?> fetchDetails;
  final String mediaType;
  final String movieId;

  const MyDetailsWidget(this.mediaType, this.fetchDetails, this.movieId,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final similarContentProvider = context.read<SimilarContentProvider>();
    final castProvider = context.read<CastProvider>();
    final videoProvider = context.read<VideoProvider>();

    Future<Map<String, dynamic>?> fetchSimilar =
        similarContentProvider.fetchSimilarContent(mediaType, movieId);
    Future<Map<String, dynamic>?> fetchCast =
        castProvider.fetchCast(mediaType, movieId);
    Future<Map<String, dynamic>?> fetchVideo =
        videoProvider.fetchVideo(movieId);

    return FutureBuilder<Map<String, dynamic>?>(
        future: fetchDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                height: MediaQuery.of(context).size.height * 2,
                child: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('No similar content available.');
          } else {
            Map<String, dynamic>? data = snapshot.data;
            print(data);

            if (data != null) {
              final posterPath = data['poster_path'];
              List<dynamic> genres = data['genres'];
              List<String> genreNames =
                  genres.map((genre) => genre['name'].toString()).toList();
              String runtime = '';
              List<String> networkName = [];
              String releaseDate = '';
              String title = '';
              int releaseYear = 0;
              String mainGenre = genreNames.isNotEmpty ? genreNames[0] : '';
              final voteAverage = data['vote_average'].toStringAsFixed(1);

              if (mediaType == 'tv') {
                List<dynamic> networks = data['networks'];
                networkName = networks.map((network) {
                  if (network.containsKey('name')) {
                    return network['name'].toString();
                  } else {
                    return '';
                  }
                }).toList();
                if (data.containsKey("first_air_date")) {
                  releaseDate = data["first_air_date"];
                  if (releaseDate != '') {
                    DateTime parsedReleaseDate = DateTime.parse(releaseDate);
                    releaseYear = parsedReleaseDate.year;
                  }
                } else {
                  releaseDate = 'No date';
                }
                title = data['name'];
              } else {
                runtime = data["runtime"].toString();
                title = data['title'];
                releaseDate = data["release_date"];
                DateTime parsedReleaseDate = DateTime.parse(releaseDate);
                releaseYear = parsedReleaseDate.year;
              }

              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 200),
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
                            child: posterPath != null
                                ? Image.network(
                                    'https://image.tmdb.org/t/p/w500/$posterPath',
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: 580,
                                  )
                                : const Icon(
                                    Icons
                                        .not_interested_sharp, // You can choose an appropriate icon
                                    size: 100, // Set the size you want
                                    color: Colors
                                        .grey, // Choose the color for the icon
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
                                      Color.fromARGB(140, 0, 0, 0),
                                      Color.fromARGB(120, 0, 0, 0),
                                      Color.fromARGB(50, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0),
                                      Color.fromRGBO(0, 0, 0, 0),
                                      Color.fromRGBO(0, 0, 0, 0.50),
                                      Color.fromRGBO(0, 0, 0, 0.90),
                                      Color.fromRGBO(0, 0, 0, 0.99),
                                      Color.fromRGBO(0, 0, 0, 1),
                                    ],
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
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 0),
                                    child: Row(
                                      children: [
                                        if (mediaType == 'tv')
                                          Text(
                                            networkName.isNotEmpty
                                                ? networkName[0]
                                                : '',
                                            style: const TextStyle(
                                                color: Color(0xFFB4B4B4)),
                                          )
                                        else
                                          Text(
                                            '$runtime MIN',
                                            style: const TextStyle(
                                                color: Color(0xFFB4B4B4)),
                                          ),
                                        const SizedBox(width: 15),
                                        Text(
                                          '$releaseYear',
                                          style: const TextStyle(
                                              color: Color(0xFFB4B4B4)),
                                        ),
                                        const SizedBox(width: 15),
                                        Text(
                                          mainGenre,
                                          style: const TextStyle(
                                              color: Color(0xFFB4B4B4)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/trailer',
                                                arguments: {
                                                  'fetchVideo': fetchVideo
                                                });
                                          },
                                          icon: const Icon(
                                            Icons.play_circle_outline,
                                            color: Colors.white,
                                            size: 70,
                                          ),
                                        ),
                                        const Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                              SizedBox(width: 15),
                                              Icon(
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
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                        child: Text(
                          title,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          data['overview'] ?? 'No details',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
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
                                color: Color.fromARGB(255, 212, 212, 212),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ExpandableContainer(mediaType, movieId, fetchCast),
                      SimilarContentWidget(mediaType, movieId, fetchSimilar)
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          }
        });
  }
}
