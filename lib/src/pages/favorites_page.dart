import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import 'package:moviesandtv_flutter/src/pages/login_page.dart';
import 'package:moviesandtv_flutter/src/providers/favorites_provider.dart';
import 'package:moviesandtv_flutter/src/providers/user_provider.dart';
import 'package:moviesandtv_flutter/src/widgets/appbar_widget.dart';
import 'package:moviesandtv_flutter/src/widgets/drawer_widget.dart';
import 'package:provider/provider.dart';
import 'package:moviesandtv_flutter/utils/api_constants.dart';

class MyFavoritesPage extends StatelessWidget {
  MyFavoritesPage({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.read<FavoritesProvider>();

    User? user = Provider.of<UserProvider>(context, listen: false).user;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerWidget(),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Column(
        children: [
          Stack(
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
          if (user != null)
            FutureBuilder<List<MovieModel>?>(
              future: favoriteProvider.getFavoriteContent(user.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(height: 500, color: Colors.black);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<MovieModel>? data = snapshot.data;
                  return SizedBox(
                    height: 330,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          color: Colors.transparent,
                          padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                          child: const Text(
                            'Favorites',
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
                                  Navigator.pushNamed(context, '/details',
                                      arguments: {
                                        'mediaType': mediaType,
                                        'movieId': movieId
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 10,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${ApiConstants.BASE_IMAGE_URL}$posterPath',
                                    width: 170,
                                    fit: BoxFit.contain,
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
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            )
          else
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'You are not signed in. ',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 212, 212, 212),
                      fontSize: 20,
                      height: 1.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign in',
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                      ),
                      const TextSpan(
                        text: ' to access personalized content.',
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
