import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import '../services/tmdb_api.dart';

class NowPlayingMoviesProvider with ChangeNotifier {
  final TMDBApi _tmdbApi;
  NowPlayingMoviesProvider(this._tmdbApi);

  Future<List<MovieModel>?> getNowPlayingMovies() async {
    try {
      final moviesResult = await _tmdbApi.getNowPlayingMovies();
      notifyListeners();
      return moviesResult;
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      throw Exception('Failed to fetch movies $e');
    }
  }
}
