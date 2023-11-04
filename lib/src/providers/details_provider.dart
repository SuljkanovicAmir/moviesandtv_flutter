import 'package:flutter/material.dart';
import '../services/tmdb_api.dart';

class DetailsProvider with ChangeNotifier {
  final TMDBApi _tmdbApi = TMDBApi();

  Map<String, dynamic> _movieDetails = {};
  Map<String, dynamic> get movieDetails => _movieDetails;

  Future<Map<String, dynamic>?> fetchDetails(mediaType, movieId) async {
    try {
      final details = await _tmdbApi.fetchDetails(mediaType, movieId);
      // ignore: unnecessary_null_comparison
      if (details != null) {
        _movieDetails = details;
        notifyListeners();
        return details;
      } else {
        debugPrint('Movie details are null or empty.');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching movie details: $e');
      return null;
    }
  }
}
