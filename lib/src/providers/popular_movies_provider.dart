import 'package:flutter/material.dart';
import '../services/tmdb_api.dart';

class PopularMoviesProvider with ChangeNotifier {
  final TMDBApi _tmdbApi = TMDBApi();

  List<Map<String, dynamic>> _popularMovies = [];
  List<Map<String, dynamic>> get popularMovies => _popularMovies;

  Future<void> fetchMovies() async {
    try {
      _popularMovies = await _tmdbApi.fecthPopularMovies();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching movies: $e');
    }
  }
}
