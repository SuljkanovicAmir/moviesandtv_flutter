import 'package:flutter/material.dart';
import '../services/tmdb_api.dart';

class VideoProvider with ChangeNotifier {
  final TMDBApi _tmdbApi;
  VideoProvider(this._tmdbApi);

  Map<String, dynamic> _video = {};
  Map<String, dynamic> get video => _video;

  void clearDetails() {
    _video.clear();
    notifyListeners();
  }

  Future<Map<String, dynamic>?> fetchVideo(movieId) async {
    try {
      final trailer = await _tmdbApi.fetchVideo(movieId);

      _video = trailer;
      notifyListeners();
      return trailer;
    } catch (e) {
      debugPrint('Error fetching movie details: $e');
      return null;
    }
  }
}
