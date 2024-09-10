import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/pages/details_page.dart';
import 'package:moviesandtv_flutter/src/pages/home_page.dart';

import 'package:moviesandtv_flutter/src/pages/trailer_page.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  if (settings.name == '/details') {
    final Map<String, dynamic> args =
        settings.arguments as Map<String, dynamic>;
    final String mediaType = args['mediaType'].toString();
    final String movieId = args['movieId'].toString();

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          DetailsPage(mediaType, movieId),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  if (settings.name == '/trailer') {
    final Map<String, dynamic> args =
        settings.arguments as Map<String, dynamic>;
    final Future<Map<String, dynamic>?> fetchVideo = args['fetchVideo'];
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          MyTrailerPage(fetchVideo),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  if (settings.name == '/') {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MyHomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  return null;
}
