import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/widgets/appbar_widget.dart';
import 'package:moviesandtv_flutter/src/widgets/drawer_widget.dart';
import 'package:moviesandtv_flutter/src/widgets/movie_carousel.dart';
import 'package:moviesandtv_flutter/src/widgets/now_playing_movies_widget.dart';
import 'package:moviesandtv_flutter/src/widgets/popular_movies_widget.dart';
import 'package:moviesandtv_flutter/src/widgets/top_movies_widget.dart';
import 'package:moviesandtv_flutter/src/widgets/upcoming_movies_widget.dart';

class MyMoviesPages extends StatelessWidget {
  MyMoviesPages({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    const String contentType = 'movie';
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
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
          child: Column(children: [
            Stack(
              children: <Widget>[
                SizedBox(
                  height: 600,
                  child: Stack(
                    children: <Widget>[
                      const MovieCarouselWidget(contentType),
                      Positioned.fill(
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
                                stops: [0.75, 0.91, 0.96],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 70),
                  child: const Center(
                      child: Text(
                    'Movies',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                AppBarWidget(_scaffoldKey)
              ],
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const NowPlayingMoviesWidget(),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const UpcomingMoviesWidget(),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const TopMoviesWidget(),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 120),
              child: const PopularMoviesWidget(),
            ),
          ]),
        ),
      ),
    );
  }
}
