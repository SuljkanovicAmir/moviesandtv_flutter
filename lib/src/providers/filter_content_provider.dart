import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import '../services/tmdb_api.dart';

class FilterContentProvider with ChangeNotifier {
  final TMDBApi _tmdbApi;
  FilterContentProvider(this._tmdbApi);

  List<MovieModel>? _filteredData = [];
  List<MovieModel>? get filteredData => _filteredData;

  Future<List<MovieModel>?> getFilteredContent(mediaType, genre) async {
    try {
      final moviesResult = await _tmdbApi.getFilteredContent(mediaType, genre);
      _filteredData = moviesResult;
      return moviesResult;
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      throw Exception('Failed to fetch popular movies $e');
    }
  }
}
