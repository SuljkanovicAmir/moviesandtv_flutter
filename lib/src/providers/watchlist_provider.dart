import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import 'package:moviesandtv_flutter/src/services/tmdb_api.dart';

class WatchlistProvider extends ChangeNotifier {
  final TMDBApi _tmdbApi;
  WatchlistProvider(this._tmdbApi);

  List<MovieModel> _watchlist = [];
  List<MovieModel> get watchlist => _watchlist;

  Future<List<MovieModel>?> getWatchlistContent(userId) async {
    try {
      final moviesResult = await _tmdbApi.getWatchlistContent(userId);
      _watchlist = moviesResult;

      notifyListeners();
      return moviesResult;
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      throw Exception('Failed to fetch movies $e');
    }
  }
}
