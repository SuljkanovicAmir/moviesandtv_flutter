import 'package:flutter/material.dart';
import '../services/tmdb_api.dart';

class UpcomingMoviesProvider with ChangeNotifier {
  final TMDBApi _tmdbApi = TMDBApi();

  List<Map<String, dynamic>> _upcomingMovies = [];
  List<Map<String, dynamic>> get upcomingMovies => _upcomingMovies;

  Future<void> fetchMovies() async {
    try {
      _upcomingMovies = await _tmdbApi.fetchUpcomingMovies();
      notifyListeners();
    } catch (e) {
      print('Error fetching movies: $e');
    }
  }
}
