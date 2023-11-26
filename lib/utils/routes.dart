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

    return MaterialPageRoute(
      builder: (context) => DetailsPage(mediaType, movieId),
    );
  }

  if (settings.name == '/trailer') {
    final Map<String, dynamic> args =
        settings.arguments as Map<String, dynamic>;
    final Future<Map<String, dynamic>?> fetchVideo = args['fetchVideo'];
    return MaterialPageRoute(
      builder: (context) => MyTrailerPage(fetchVideo),
    );
  }

  if (settings.name == '/') {
    return MaterialPageRoute(
      builder: (context) => MyHomePage(),
    );
  }

  return null;
}
