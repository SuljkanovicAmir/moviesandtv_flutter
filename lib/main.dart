import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/pages/details_page.dart';
import 'package:moviesandtv_flutter/src/pages/home_page.dart';
import 'package:moviesandtv_flutter/src/pages/trailer_page.dart';
import 'package:moviesandtv_flutter/src/providers/cast_provider.dart';
import 'package:moviesandtv_flutter/src/providers/details_provider.dart';
import 'package:moviesandtv_flutter/src/providers/popular_movies_provider.dart';
import 'package:moviesandtv_flutter/src/providers/movie_provider.dart';
import 'package:moviesandtv_flutter/src/providers/search_provider.dart';
import 'package:moviesandtv_flutter/src/providers/similar_content_provide.dart';
import 'package:moviesandtv_flutter/src/providers/top_movies_provider.dart';
import 'package:moviesandtv_flutter/src/providers/upcoming_movies_provider.dart';
import 'package:moviesandtv_flutter/src/providers/video_provider.dart';
import 'package:provider/provider.dart';

import 'src/widgets/my_app_bottom_navigation_bar.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
        ChangeNotifierProvider(create: (_) => DetailsProvider()),
        ChangeNotifierProvider(create: (_) => TopMoviesProvider()),
        ChangeNotifierProvider(create: (_) => UpcomingMoviesProvider()),
        ChangeNotifierProvider(create: (_) => VideoProvider()),
        ChangeNotifierProvider(create: (_) => CastProvider()),
        ChangeNotifierProvider(create: (_) => PopularMoviesProvider()),
        ChangeNotifierProvider(create: (_) => SimilarContentProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return MaterialApp(
      title: 'Cineboxd',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            background: Colors.black,
            seedColor: const Color.fromARGB(0, 104, 58, 183)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/details') {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;
          final String mediaType = args['mediaType'].toString();
          final String movieId = args['movieId'].toString();
          final detailsProvider =
              Provider.of<DetailsProvider>(context, listen: false);

          return MaterialPageRoute(
            builder: (context) =>
                DetailsPage(mediaType, movieId, detailsProvider),
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
            builder: (context) => const MyHomePage(),
          );
        }
        return null;
      },
      home: MyAppBottomNavigationBar(searchProvider),
    );
  }
}
