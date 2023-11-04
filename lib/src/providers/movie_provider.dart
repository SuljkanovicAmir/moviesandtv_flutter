import 'package:flutter/material.dart';
import '../services/tmdb_api.dart';

class MovieProvider with ChangeNotifier {
  final TMDBApi _tmdbApi = TMDBApi();

  List<Map<String, dynamic>> _movies = [];
  List<Map<String, dynamic>> get movies => _movies;

  void resetData() {
    _movies = [];
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>?> fetchMovies(String contentType) async {
    try {
      final moviesData = await _tmdbApi.fetchMovies(contentType);
      notifyListeners();
      // ignore: unnecessary_null_comparison
      if (moviesData != null) {
        _movies = moviesData;
        notifyListeners();
        return moviesData;
      } else {
        debugPrint('Cast are null or empty.');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching cast: $e');
      return null;
    }
  }
}
