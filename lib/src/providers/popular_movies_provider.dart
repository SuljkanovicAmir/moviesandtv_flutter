import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import '../services/tmdb_api.dart';

class PopularMoviesProvider with ChangeNotifier {
  final TMDBApi _tmdbApi;
  PopularMoviesProvider(this._tmdbApi);

  Future<List<MovieModel>?> getPopularMovies() async {
    try {
      final moviesResult = await _tmdbApi.getPopularMovies();
      return moviesResult;
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      throw Exception('Failed to fetch popular movies $e');
    }
  }
}
