import 'package:http/http.dart';
import 'package:moviesandtv_flutter/main.dart';
import 'package:moviesandtv_flutter/src/providers/watchlist_provider.dart';
import 'package:moviesandtv_flutter/src/services/tmdb_api.dart';
import 'package:moviesandtv_flutter/utils/api_client.dart';
import 'package:provider/provider.dart';
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
import 'package:moviesandtv_flutter/src/providers/video_provider.dart'; // Import your API or service file

MultiProvider buildAppProviders() {
  final apiClient = ApiClient(Client());
  final tmdbApi = TMDBApi(apiClient);

  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MovieProvider(tmdbApi)),
      ChangeNotifierProvider(create: (_) => UserProvider()),
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
      ChangeNotifierProvider(create: (_) => WatchlistProvider(tmdbApi)),
      ChangeNotifierProvider(create: (_) => NowPlayingMoviesProvider(tmdbApi)),
    ],
    child: const MyApp(),
  );
}
