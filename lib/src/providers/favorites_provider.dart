import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import 'package:moviesandtv_flutter/src/services/tmdb_api.dart';

class FavoritesProvider extends ChangeNotifier {
  final TMDBApi _tmdbApi;
  FavoritesProvider(this._tmdbApi);

  List<MovieModel> _favorites = [];
  List<MovieModel> get favorites => _favorites;

  Future<List<MovieModel>?> getFavoriteContent(userId) async {
    try {
      final moviesResult = await _tmdbApi.getFavoriteContent(userId);
      _favorites = moviesResult;

      notifyListeners();
      return moviesResult;
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      throw Exception('Failed to fetch movies $e');
    }
  }
}
