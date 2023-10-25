import 'package:flutter/material.dart';
import '../services/tmdb_api.dart';

class MovieProvider with ChangeNotifier {
  final TMDBApi _tmdbApi = TMDBApi();

  List<Map<String, dynamic>> _movies = [];
  List<Map<String, dynamic>> get movies => _movies;

  Future<void> fetchMovies() async {
    try {
      _movies = await _tmdbApi.fetchMovies();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching movies: $e');
    }
  }
}
