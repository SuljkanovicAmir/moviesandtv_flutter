import 'package:flutter/material.dart';
import '../services/tmdb_api.dart';

class CastProvider with ChangeNotifier {
  final TMDBApi _tmdbApi = TMDBApi();

  Map<String, dynamic> _cast = {};
  Map<String, dynamic> get cast => _cast;

  void clearDetails() {
    _cast.clear();
    notifyListeners();
  }

  Future<Map<String, dynamic>?> fetchCast(mediaType, movieId) async {
    try {
      final castData = await _tmdbApi.fetchCast(mediaType, movieId);
      // ignore: unnecessary_null_comparison
      if (castData != null) {
        _cast = castData;
        notifyListeners();
        return castData;
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
