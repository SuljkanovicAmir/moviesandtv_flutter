import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import 'package:moviesandtv_flutter/src/providers/favorites_provider.dart';
import 'package:moviesandtv_flutter/src/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:moviesandtv_flutter/utils/api_constants.dart';

class MyFavoritesPage extends StatelessWidget {
  const MyFavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.read<FavoritesProvider>();

    User? user = Provider.of<UserProvider>(context, listen: false).user;

    return FutureBuilder<List<MovieModel>?>(
      future: favoriteProvider.getFavoriteContent(user?.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.transparent,
            height: 200,
            child: const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<MovieModel>? data = snapshot.data;
          return Container(
            color: Colors.transparent,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: data!.length,
              // physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final movie = data[index];

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
                    child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(75, 58, 58, 58),
                              spreadRadius: 0,
                              blurRadius: 0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.only(bottom: 20),
                        height: 150,
                        width: MediaQuery.sizeOf(context).width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  '${ApiConstants.BASE_IMAGE_URL}${movie.posterPath}',
                              fit: BoxFit.contain,
                              placeholder: (context, url) => Center(
                                child: Container(
                                  color: const Color.fromARGB(133, 49, 49, 49),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  movie.title.isNotEmpty
                                      ? movie.title
                                      : movie.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  softWrap: true,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )));
              },
            ),
          );
        }
      },
    );
  }
}


/* Stack(
            children: [
              AppBarWidget(_scaffoldKey),
              Container(
                  margin: const EdgeInsets.only(top: 70),
                  child: const Center(
                      child: Text(
                    'Favorites',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ))),
            ],
          ), 

          */