import 'package:flutter/material.dart';
import '../services/tmdb_api.dart';

class SimilarContentProvider with ChangeNotifier {
  final TMDBApi _tmdbApi = TMDBApi();

  Map<String, dynamic> _similar = {};
  Map<String, dynamic> get similar => _similar;

  void clearDetails() {
    _similar.clear();
    notifyListeners();
  }

  Future<Map<String, dynamic>?> fetchSimilarContent(mediaType, movieId) async {
    try {
      final similarData =
          await _tmdbApi.fetchSimilarContent(mediaType, movieId);
      // ignore: unnecessary_null_comparison
      if (similarData != null) {
        _similar = similarData;
        notifyListeners();
        return similarData;
      } else {
        debugPrint('Cast are null or empty.');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching cast: $e');
      return null;
    }
  }
}
