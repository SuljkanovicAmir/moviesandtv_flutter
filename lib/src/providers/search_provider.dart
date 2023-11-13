import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import '../services/tmdb_api.dart';

class SearchProvider with ChangeNotifier {
  final TMDBApi _tmdbApi;
  SearchProvider(this._tmdbApi);

  List<MovieModel>? _searchData = [];
  List<MovieModel>? get searchData => _searchData;

  void clearDetails() {
    _searchData?.clear();
    notifyListeners();
  }

  Future<List<MovieModel>?> getSearch(query) async {
    try {
      final moviesResult = await _tmdbApi.getSearch(query);
      _searchData = moviesResult;
      notifyListeners();
      return moviesResult;
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      throw Exception('Failed to fetch movies $e');
    }
  }
}
