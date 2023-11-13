import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_details_model.dart';
import 'package:moviesandtv_flutter/src/pages/login_page.dart';
import 'package:moviesandtv_flutter/src/pages/profile_page.dart';
import 'package:moviesandtv_flutter/src/providers/details_provider.dart';
import 'package:moviesandtv_flutter/src/providers/user_provider.dart';
import 'package:moviesandtv_flutter/src/widgets/details_widget.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  final String mediaType;
  final String movieId;

  const DetailsPage(this.mediaType, this.movieId, {super.key});

  @override
  Widget build(BuildContext context) {
    final detailsProvider = context.read<DetailsProvider>();
    User? user = Provider.of<UserProvider>(context).user;

    Future<MovieDetailModel?> fetchDetails =
        detailsProvider.getMovieDetails(mediaType, movieId);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color(0xFF000000),
                  Color(0xFF000000),
                  Color(0xFF041125),
                  Color(0xFF061525),
                ],
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              MyDetailsWidget(mediaType, fetchDetails, movieId),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: AppBar(
                automaticallyImplyLeading: false,
                iconTheme: const IconThemeData(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: 30.0,
                        width: 30.0,
                        child: IconButton(
                          padding: const EdgeInsets.all(0.0),
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      child: const Text(
                        'Cineboxd',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Container(
                        width: 30,
                        height: 30,
                        clipBehavior: Clip.hardEdge,
                        decoration: user != null
                            ? BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: const Color.fromARGB(255, 51, 22, 131),
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0)),
                              )
                            : BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: const Color.fromARGB(0, 51, 22, 131),
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0)),
                              ),
                        child: user != null
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ProfilePage(),
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundImage:
                                      NetworkImage(user.photoURL ?? ''),
                                ),
                              )
                            : IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        offset: Offset(1.2, 0))
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                              )),
                  ],
                ),
                centerTitle: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                scrolledUnderElevation: 0.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
