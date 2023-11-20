import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:moviesandtv_flutter/firebase_options.dart';
import 'package:moviesandtv_flutter/src/pages/details_page.dart';
import 'package:moviesandtv_flutter/src/pages/home_page.dart';
import 'package:moviesandtv_flutter/src/pages/trailer_page.dart';
import 'package:moviesandtv_flutter/src/providers/anime_provider.dart';
import 'package:moviesandtv_flutter/src/providers/cast_provider.dart';
import 'package:moviesandtv_flutter/src/providers/details_provider.dart';
import 'package:moviesandtv_flutter/src/providers/favorites_provider.dart';
import 'package:moviesandtv_flutter/src/providers/filter_content_provider.dart';
import 'package:moviesandtv_flutter/src/providers/now_playing_provider.dart';
import 'package:moviesandtv_flutter/src/providers/on_air_provider.dart';
import 'package:moviesandtv_flutter/src/providers/popular_movies_provider.dart';
import 'package:moviesandtv_flutter/src/providers/movie_provider.dart';
import 'package:moviesandtv_flutter/src/providers/popular_tv_provider.dart';
import 'package:moviesandtv_flutter/src/providers/search_provider.dart';
import 'package:moviesandtv_flutter/src/providers/similar_content_provide.dart';
import 'package:moviesandtv_flutter/src/providers/top_movies_provider.dart';
import 'package:moviesandtv_flutter/src/providers/upcoming_movies_provider.dart';
import 'package:moviesandtv_flutter/src/providers/user_provider.dart';
import 'package:moviesandtv_flutter/src/providers/video_provider.dart';
import 'package:moviesandtv_flutter/src/services/firebase_notif.dart';
import 'package:moviesandtv_flutter/src/services/tmdb_api.dart';
import 'package:moviesandtv_flutter/utils/api_client.dart';
import 'package:provider/provider.dart';

import 'src/widgets/my_app_bottom_navigation_bar.dart';

void main() async {
  final apiClient = ApiClient(Client());
  final tmdbApi = TMDBApi(apiClient);
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseNotif().initNotification();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider(tmdbApi)),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (_) => DetailsProvider(tmdbApi)),
        ChangeNotifierProvider(create: (_) => TopMoviesProvider(tmdbApi)),
        ChangeNotifierProvider(create: (_) => UpcomingMoviesProvider(tmdbApi)),
        ChangeNotifierProvider(create: (_) => VideoProvider(tmdbApi)),
        ChangeNotifierProvider(create: (_) => PopularTVProvider(tmdbApi)),
        ChangeNotifierProvider(create: (_) => AnimeProvider(tmdbApi)),
        ChangeNotifierProvider(create: (_) => FilterContentProvider(tmdbApi)),
        ChangeNotifierProvider(create: (_) => CastProvider(tmdbApi)),
        ChangeNotifierProvider(create: (_) => PopularMoviesProvider(tmdbApi)),
        ChangeNotifierProvider(create: (_) => SimilarContentProvider(tmdbApi)),
        ChangeNotifierProvider(create: (_) => OnAirProvider(tmdbApi)),
        ChangeNotifierProvider(create: (_) => SearchProvider(tmdbApi)),
        ChangeNotifierProvider(create: (_) => FavoritesProvider(tmdbApi)),
        ChangeNotifierProvider(
            create: (_) => NowPlayingMoviesProvider(tmdbApi)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    userProvider.initializeUser();

    return MaterialApp(
      title: 'Cineboxd',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            background: Colors.black,
            seedColor: const Color.fromARGB(0, 104, 58, 183)),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
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
      },
      home: MyAppBottomNavigationBar(searchProvider),
    );
  }
}
