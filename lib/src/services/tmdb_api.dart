import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:moviesandtv_flutter/src/models/movie_model.dart';
import 'package:moviesandtv_flutter/src/models/movie_details_model.dart';
import 'package:moviesandtv_flutter/src/models/movies_result_model.dart';
import 'package:moviesandtv_flutter/utils/api_client.dart';

class TMDBApi {
  static const apiKey = '9c48504327319ce49f2a496c8b5456b7';
  static const baseUrl = 'https://api.themoviedb.org/3';

  final ApiClient _apiClient;

  TMDBApi(this._apiClient);

  Future<List<MovieModel>> getContentCarousel(contentType) async {
    try {
      final response = await _apiClient.get('trending/$contentType/week');
      return MoviesResultModel.fromJson(response).movies;
    } catch (e) {
      print('Error fetching movies: $e');
      throw Exception('Failed to load movies');
    }
  }

  Future<MovieDetailModel> getMovieDetails(mediaType, movieId) async {
    try {
      final response = await _apiClient.get('$mediaType/$movieId');
      final Map<String, dynamic> responseBody = response;
      var movieDetails = MovieDetailModel.fromJson(responseBody);

      return movieDetails;
    } catch (e) {
      print('Error fetching movie details: $e');
      throw Exception('Failed to load movie details');
    }
  }

  Future<List<MovieModel>> getTopMovies() async {
    final params = {
      'primary_release_year': 2023,
      'language': 'en-US',
      'page': 1,
      'sort_by': 'vote_average.desc',
      'without_genres': '99,10755',
      'vote_count.gte': 200,
    };
    final response = await _apiClient.get('discover/movie', params: params);
    try {
      return MoviesResultModel.fromJson(response).movies;
    } catch (e) {
      print('Error fetching movies: $e');
      throw Exception('Failed to load movies');
    }
  }

  Future<List<MovieModel>> getUpcomingMovies() async {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    final tomorrowFormatted =
        '${tomorrow.year}-${tomorrow.month.toString().padLeft(2, '0')}-${tomorrow.day.toString().padLeft(2, '0')}';

    final params = {
      'region': 'US',
      'language': 'en-US',
      'release_date.gte': tomorrowFormatted
    };

    try {
      final response = await _apiClient.get('movie/upcoming', params: params);
      return MoviesResultModel.fromJson(response).movies;
    } catch (e) {
      print('Error fetching movies: $e');
      throw Exception('Failed to load movies');
    }
  }

  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final response = await _apiClient.get('movie/popular');
      return MoviesResultModel.fromJson(response).movies;
    } catch (e) {
      print('Error fetching movies: $e');
      throw Exception('Failed to load movies');
    }
  }

  Future<List<MovieModel>> getNowPlayingMovies() async {
    try {
      final response = await _apiClient.get('movie/now_playing');

      return MoviesResultModel.fromJson(response).movies;
    } catch (e) {
      print('Error fetching now playing movies: $e');
      throw Exception('Failed to load movies');
    }
  }

  Future<Map<String, dynamic>> fetchVideo(movieId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/movie/$movieId/videos?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      var movieDetails = responseBody;

      return movieDetails;
    } else {
      print('Response Body: ${response.body}');
      throw Exception('Failed to load movie details');
    }
  }

  Future<Map<String, dynamic>> fetchCast(mediaType, movieId) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/$mediaType/$movieId/credits?api_key=$apiKey&limit=10'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      var cast = responseBody;

      return cast;
    } else {
      print('Response Body: ${response.body}');
      throw Exception('Failed to load movie details');
    }
  }

  Future<List<MovieModel>> getSimilarContent(mediaType, movieId) async {
    try {
      final response = await _apiClient.get('$mediaType/$movieId/similar');
      return MoviesResultModel.fromJson(response).movies;
    } catch (e) {
      print('Error fetching now playing movies: $e');
      throw Exception('Failed fetching now playing movies');
    }
  }

  Future<List<MovieModel>> getSearch(query) async {
    final response =
        await _apiClient.get('search/multi', params: {'query': query});
    try {
      final data = MoviesResultModel.fromJson(response).movies;
      return data;
    } catch (e) {
      print('Error fetching movies: $e');
      throw Exception('Failed to load movies');
    }
  }

  Future<List<MovieModel>> getOnAir() async {
    final DateTime now = DateTime.now();
    final DateTime nextWeek = now.add(const Duration(days: 7));

    final params = {
      'include_adult': false,
      'language': 'en-US',
      'with_original_language': 'en',
      'page': 1,
      'sort_by': 'popularity.desc',
      'primary_release_date.lte': now.toIso8601String(),
      'primary_release_date.gte': nextWeek.toIso8601String(),
    };

    final response = await _apiClient.get('discover/tv', params: params);

    try {
      return MoviesResultModel.fromJson(response).movies;
    } catch (e) {
      print('Error fetching movies: $e');
      throw Exception('Failed to load movies');
    }
  }

  Future<List<MovieModel>> getPopularTVShows() async {
    final params = {
      'include_adult': false,
      'language': 'en-US',
      'page': 1,
      'sort_by': 'popularity.desc',
      'first_air_date.gte': '2010-01-01',
      'first_air_date.lte': '2020-12-31',
      'vote_count.gte': 100,
    };

    final response = await _apiClient.get('discover/tv', params: params);

    try {
      return MoviesResultModel.fromJson(response).movies;
    } catch (e) {
      print('Error fetching popular TV shows: $e');
      throw Exception('Failed to load popular TV shows');
    }
  }

  Future<List<MovieModel>> getTopRatedAnimeTVShows() async {
    final params = {
      'include_adult': false,
      'with_origin_country': 'JP',
      'with_original_language': 'ja',
      'page': 1,
      'sort_by': 'popularity.desc',
      'with_genres': '16',
      'first_air_date.gte': '2010-01-01',
      'first_air_date.lte': '2019-12-31',
      'vote_count.gte': 100,
    };

    final response = await _apiClient.get('discover/tv', params: params);

    try {
      return MoviesResultModel.fromJson(response).movies;
    } catch (e) {
      print('Error fetching top-rated anime TV shows: $e');
      throw Exception('Failed to load top-rated anime TV shows');
    }
  }

  Future<List<MovieModel>> getFilteredContent(mediaType, genre) async {
    final params = {
      'include_adult': false,
      'sort_by': 'popularity.desc',
      'with_genres': genre,
      'vote_count.gte': 10,
    };

    final response =
        await _apiClient.get('discover/$mediaType', params: params);

    try {
      return MoviesResultModel.fromJson(response).movies;
    } catch (e) {
      print('Error fetching top-rated anime TV shows: $e');
      throw Exception('Failed to load top-rated anime TV shows');
    }
  }

  Future<List<MovieModel>> getFavoriteContent(userId) async {
    final List<Map<String, dynamic>> favorites = await fetchFavorites(userId);

    List<dynamic> responses = [];
    Map<String, dynamic> results = {};

    try {
      for (Map<String, dynamic> favorite in favorites) {
        final movieId = favorite['movieId'];
        final mediaType = favorite['mediaType'];
        final response = await _apiClient.get('$mediaType/$movieId');
        responses.add(response);
        results = {'results': responses};
      }

      print('results $results');
      return MoviesResultModel.fromJson(results).movies;
    } catch (e) {
      print('Error fetching movies: $e');
      throw Exception('Failed to load movies');
    }
  }
}

Future<List<Map<String, dynamic>>> fetchFavorites(String userId) async {
  try {
    final DocumentSnapshot<Map<String, dynamic>> document =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    final List<dynamic> favorites = document.data()?['favorites'] ?? [];

    List<Map<String, dynamic>> favoritesList = favorites.map((fav) {
      return {
        'movieId': fav['movieId'],
        'mediaType': fav['mediaType'],
      };
    }).toList();

    return favoritesList;
  } catch (e) {
    print('Error fetching favorites: $e');
    throw Exception('Failed to fetch favorites');
  }
}
