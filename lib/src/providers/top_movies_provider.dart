import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import '../services/tmdb_api.dart';

class TopMoviesProvider with ChangeNotifier {
  final TMDBApi _tmdbApi;
  TopMoviesProvider(this._tmdbApi);

  Future<List<MovieModel>?> getTopMovies() async {
    try {
      final moviesResult = await _tmdbApi.getTopMovies();

      notifyListeners();
      return moviesResult;
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      throw Exception('Failed to fetch movies $e');
    }
  }
}
