import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import '../services/tmdb_api.dart';

class OnAirProvider with ChangeNotifier {
  final TMDBApi _tmdbApi;
  OnAirProvider(this._tmdbApi);

  Future<List<MovieModel>?> getOnAir() async {
    try {
      final moviesResult = await _tmdbApi.getOnAir();
      return moviesResult;
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      throw Exception('Failed to fetch popular movies $e');
    }
  }
}
