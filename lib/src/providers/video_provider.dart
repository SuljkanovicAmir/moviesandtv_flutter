import 'package:flutter/material.dart';
import '../services/tmdb_api.dart';

class VideoProvider with ChangeNotifier {
  final TMDBApi _tmdbApi = TMDBApi();

  Map<String, dynamic> _video = {};
  Map<String, dynamic> get video => _video;

  void clearDetails() {
    _video.clear();
    notifyListeners();
  }

  Future<Map<String, dynamic>?> fetchVideo(movieId) async {
    try {
      final trailer = await _tmdbApi.fetchVideo(movieId);
      // ignore: unnecessary_null_comparison
      if (trailer != null) {
        _video = trailer;
        notifyListeners();
        return trailer;
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
