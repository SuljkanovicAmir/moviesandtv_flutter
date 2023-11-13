import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import '../services/tmdb_api.dart';

class MovieProvider with ChangeNotifier {
  final TMDBApi _tmdbApi;
  MovieProvider(this._tmdbApi);

  Future<List<MovieModel>?> getContentCarousel(contentType) async {
    try {
      final moviesResult = await _tmdbApi.getContentCarousel(contentType);
      notifyListeners();
      return moviesResult;
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      throw Exception('Failed to fetch movies $e');
    }
  }
}
