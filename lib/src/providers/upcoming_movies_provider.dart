import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import '../services/tmdb_api.dart';

class UpcomingMoviesProvider with ChangeNotifier {
  final TMDBApi _tmdbApi;
  UpcomingMoviesProvider(this._tmdbApi);

  Future<List<MovieModel>?> getUpcomingMovies() async {
    try {
      final moviesResult = await _tmdbApi.getUpcomingMovies();
      notifyListeners();
      return moviesResult;
    } catch (e) {
      print('Error fetching movies: $e');
      throw Exception('Failed to fetch movies $e');
    }
  }
}
