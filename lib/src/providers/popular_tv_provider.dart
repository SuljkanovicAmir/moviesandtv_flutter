import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import '../services/tmdb_api.dart';

class PopularTVProvider with ChangeNotifier {
  final TMDBApi _tmdbApi;
  PopularTVProvider(this._tmdbApi);

  Future<List<MovieModel>?> getPopularTVShows() async {
    try {
      final moviesResult = await _tmdbApi.getPopularTVShows();
      return moviesResult;
    } catch (e) {
      debugPrint('Error fetching movies: $e');
      throw Exception('Failed to fetch popular movies $e');
    }
  }
}
