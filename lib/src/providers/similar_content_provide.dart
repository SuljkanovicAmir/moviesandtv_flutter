import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import '../services/tmdb_api.dart';

class SimilarContentProvider with ChangeNotifier {
  final TMDBApi _tmdbApi;
  SimilarContentProvider(this._tmdbApi);

  Future<List<MovieModel>?> getSimilarContent(mediaType, movieId) async {
    try {
      final moviesResult = await _tmdbApi.getSimilarContent(mediaType, movieId);
      notifyListeners();
      return moviesResult;
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      throw Exception('Failed to fetch movies $e');
    }
  }
}
