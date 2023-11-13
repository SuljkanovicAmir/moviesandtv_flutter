import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/pages/details_page.dart';
import 'package:moviesandtv_flutter/src/pages/movies_page.dart';
import 'package:moviesandtv_flutter/src/pages/search_page.dart';
import 'package:moviesandtv_flutter/src/pages/trailer_page.dart';

import 'package:moviesandtv_flutter/src/providers/search_provider.dart';
import 'package:provider/provider.dart';

class AppRoutes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/details':
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        final String mediaType = args['mediaType'].toString();
        final String movieId = args['movieId'].toString();

        return MaterialPageRoute(
          builder: (context) {
            return DetailsPage(mediaType, movieId);
          },
        );

      case '/trailer':
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        final Future<Map<String, dynamic>?> fetchVideo = args['fetchVideo'];
        return MaterialPageRoute(
          builder: (context) => MyTrailerPage(fetchVideo),
        );
      case '/search':
        return MaterialPageRoute(
          builder: (context) {
            final searchProvider =
                Provider.of<SearchProvider>(context, listen: false);
            return MySearchPage(searchProvider);
          },
        );
      case '/movies':
        return MaterialPageRoute(
          builder: (context) => MyMoviesPages(),
        );
      default:
        return null;
    }
  }
}
