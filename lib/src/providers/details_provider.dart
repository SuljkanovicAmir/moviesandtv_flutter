import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/models/movie_details_model.dart';
import '../services/tmdb_api.dart';

class DetailsProvider with ChangeNotifier {
  final TMDBApi _tmdbApi;
  DetailsProvider(this._tmdbApi);

  MovieDetailModel? _movieDetails;
  MovieDetailModel? get movieDetails => _movieDetails;

  Future<MovieDetailModel?> getMovieDetails(mediaType, movieId) async {
    try {
      final details = await _tmdbApi.getMovieDetails(mediaType, movieId);
      _movieDetails = details;
      notifyListeners();
      return details;
    } catch (e) {
      debugPrint('Error fetching movie details: $e');
      return null;
    }
  }
}
