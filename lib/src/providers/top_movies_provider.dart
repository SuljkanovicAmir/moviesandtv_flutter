import 'package:flutter/material.dart';
import '../services/tmdb_api.dart';

class TopMoviesProvider with ChangeNotifier {
  final TMDBApi _tmdbApi = TMDBApi();

  List<Map<String, dynamic>> _topMovies = [];
  List<Map<String, dynamic>> get topMovies => _topMovies;

  Future<void> fetchMovies() async {
    try {
      _topMovies = await _tmdbApi.fetchTopMovies();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching movies: $e');
    }
  }
}
