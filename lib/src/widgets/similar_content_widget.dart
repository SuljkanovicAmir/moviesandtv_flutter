import 'package:flutter/material.dart';

class SimilarContentWidget extends StatelessWidget {
  final String mediaType;
  final String movieId;
  final Future<Map<String, dynamic>?> fetchSimilar;

  const SimilarContentWidget(this.mediaType, this.movieId, this.fetchSimilar,
      {super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
        future: fetchSimilar,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('No similar content available.');
          } else {
            Map<String, dynamic>? similarData = snapshot.data;
            final data = similarData?['results'];

            if (data.isNotEmpty) {
              return SizedBox(
                height: 330,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      color: Colors.transparent,
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                      child: const Text(
                        'Similar',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 260,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final movie = data[index];
                          final posterPath = movie['poster_path'];
                          if (posterPath != null) {
                            return GestureDetector(
                                onTap: () {
                                  final movieId = movie['id'];
                                  String mediaType = '';
                                  if (movie.containsKey('title')) {
                                    mediaType = 'movie';
                                  } else {
                                    mediaType = 'tv';
                                  }
                                  Navigator.pushNamed(context, '/similar',
                                      arguments: {
                                        'mediaType': mediaType,
                                        'movieId': movieId
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/w500/$posterPath',
                                    width: 170,
                                    fit: BoxFit.contain,
                                  ),
                                ));
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }
        });
  }
}
