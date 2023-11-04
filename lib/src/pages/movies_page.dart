import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/widgets/movie_carousel.dart';
import 'package:moviesandtv_flutter/src/widgets/popular_movies_widget.dart';
import 'package:moviesandtv_flutter/src/widgets/top_movies_widget.dart';
import 'package:moviesandtv_flutter/src/widgets/upcoming_movies_widget.dart';

class MyMoviesPages extends StatelessWidget {
  const MyMoviesPages({super.key});

  @override
  Widget build(BuildContext context) {
    const String contentType = 'movie';
    return Scaffold(
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
                  height: 640,
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
                                  Color.fromARGB(140, 0, 0, 0),
                                  Color.fromARGB(120, 0, 0, 0),
                                  Color.fromARGB(120, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0),
                                  Color.fromRGBO(0, 0, 0, 0),
                                  Color.fromRGBO(0, 0, 0, 0.70),
                                  Color.fromRGBO(0, 0, 0, 0.99),
                                  Color.fromRGBO(0, 0, 0, 1),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 70),
                  child: const Center(
                      child: Text(
                    'Movies',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: AppBar(
                      title: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          Text(
                            'HBO',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      centerTitle: false,
                      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                      elevation: 0,
                      scrolledUnderElevation: 0.0,
                    ),
                  ),
                ),
              ],
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
