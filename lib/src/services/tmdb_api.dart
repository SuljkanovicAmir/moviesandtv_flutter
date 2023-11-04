import 'package:http/http.dart' as http;
import 'dart:convert';

class TMDBApi {
  static const apiKey = '9c48504327319ce49f2a496c8b5456b7';
  static const baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Map<String, dynamic>>> fetchMovies(contentType) async {
    final response = await http
        .get(Uri.parse('$baseUrl/trending/$contentType/week?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> results = responseBody['results'];

      final List<Map<String, dynamic>> movies = results
          .whereType<Map<String, dynamic>>()
          .toList(); // Only include items that are maps

      return movies;
    } else {
      print('Response Body: ${response.body}');
      throw Exception('Failed to load movies');
    }
  }

  Future<Map<String, dynamic>> fetchDetails(mediaType, movieId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/$mediaType/$movieId?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      var movieDetails = responseBody;

      return movieDetails;
    } else {
      print('Response Body: ${response.body}');
      throw Exception('Failed to load movie details');
    }
  }

  Future<List<Map<String, dynamic>>> fetchTopMovies() async {
    final response = await http.get(Uri.parse(
        '$baseUrl/discover/movie?api_key=$apiKey&primary_release_year=2023&language=en-US&page=1&sort_by=vote_average.desc&without_genres=99,10755&vote_count.gte=200'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> results = responseBody['results'];

      final List<Map<String, dynamic>> topMovies = results
          .whereType<Map<String, dynamic>>()
          .toList(); // Only include items that are maps

      return topMovies;
    } else {
      print('Response Body: ${response.body}');
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Map<String, dynamic>>> fetchUpcomingMovies() async {
    final now = DateTime.now();
    final today =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    final response = await http.get(Uri.parse(
        '$baseUrl/movie/upcoming?api_key=$apiKey&region=US&language=en-US&release_date.gte=$today'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> results = responseBody['results'];

      final List<Map<String, dynamic>> upcomingMovies = results
          .whereType<Map<String, dynamic>>()
          .toList(); // Only include items that are maps

      return upcomingMovies;
    } else {
      print('Response Body: ${response.body}');
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

  Future<List<Map<String, dynamic>>> fecthPopularMovies() async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&sort_by=popularity.desc'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> results = responseBody['results'];

      final List<Map<String, dynamic>> popularMovies =
          results.whereType<Map<String, dynamic>>().toList();

      return popularMovies;
    } else {
      print('Response Body: ${response.body}');
      throw Exception('Failed to popular movies');
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

  Future<Map<String, dynamic>> fetchSimilarContent(mediaType, movieId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/$mediaType/$movieId/similar?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      var similar = responseBody;

      return similar;
    } else {
      print('Response Body: ${response.body}');
      throw Exception('Failed to similar content');
    }
  }

  Future<Map<String, dynamic>> fetchSearch(query) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/search/multi?api_key=$apiKey&query=$query&include_adult=false&include_video=false'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      var searchData = responseBody;

      return searchData;
    } else {
      print('Response Body: ${response.body}');
      throw Exception('Failed to find content');
    }
  }

  Future<List<Map<String, dynamic>>> fetchNowPlayingMovies() async {
    final response =
        await http.get(Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> results = responseBody['results'];

      final List<Map<String, dynamic>> movies =
          results.whereType<Map<String, dynamic>>().toList();

      return movies;
    } else {
      print('Response Body: ${response.body}');
      throw Exception('Failed to load movies');
    }
  }
}
