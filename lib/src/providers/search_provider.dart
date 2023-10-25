import 'package:flutter/material.dart';
import '../services/tmdb_api.dart';

class SearchProvider with ChangeNotifier {
  final TMDBApi _tmdbApi = TMDBApi();

  Map<String, dynamic> _searchData = {};
  Map<String, dynamic> get searchData => _searchData;

  void clearDetails() {
    _searchData.clear();
    notifyListeners();
  }

  Future<Map<String, dynamic>?> fetchSearch(query) async {
    try {
      final details = await _tmdbApi.fetchSearch(query);
      // ignore: unnecessary_null_comparison
      if (details != null) {
        _searchData = details;
        notifyListeners();
        return details;
      } else {
        debugPrint('Search data is null or empty.');
        return null;
      }
    } catch (e) {
      debugPrint('Error finding content: $e');
      return null;
    }
  }
}
