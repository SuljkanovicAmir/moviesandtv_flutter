import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import '../services/tmdb_api.dart';

class AnimeProvider with ChangeNotifier {
  final TMDBApi _tmdbApi;
  AnimeProvider(this._tmdbApi);

  Future<List<MovieModel>?> getTopRatedAnimeTVShows() async {
    try {
      final moviesResult = await _tmdbApi.getTopRatedAnimeTVShows();
      return moviesResult;
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      throw Exception('Failed to fetch popular movies $e');
    }
  }
}
