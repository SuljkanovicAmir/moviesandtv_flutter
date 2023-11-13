import 'package:moviesandtv_flutter/src/domain/entities/movie_details.entity.dart';

class MovieDetailModel extends MovieDetailEntity {
  @override
  final int id;
  @override
  final String title;
  @override
  final String? releaseDate;
  @override
  final String posterPath;
  @override
  final String? voteAverage;
  @override
  final String? backdropPath;
  @override
  final String? overview;
  final String? runtime;
  final String? networkName;

  MovieDetailModel(
      {required this.id,
      required this.title,
      required this.releaseDate,
      required this.posterPath,
      required this.backdropPath,
      this.voteAverage,
      this.overview,
      this.runtime,
      this.networkName})
      : super(
          id: id,
          title: title,
          posterPath: posterPath,
          backdropPath: backdropPath,
          releaseDate: releaseDate,
          overview: overview,
          voteAverage: voteAverage,
        );

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> networks = json['networks'] ?? [];
    String? networkName = networks.isNotEmpty ? networks[0]['name'] : '';

    return MovieDetailModel(
      id: json['id'],
      title: json['title'] ?? json['name'] ?? 'Unknown Title',
      voteAverage: json['vote_average']?.toStringAsFixed(1) ?? '0.0',
      releaseDate: json['release_date'] ?? json['first_air_time'] ?? '',
      posterPath: json['poster_path'],
      overview: json['overview'] ?? '',
      runtime: json['runtime']?.toString() ?? '',
      backdropPath: json['backdrop_path'],
      networkName: networkName,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vote_average'] = voteAverage;
    data['title'] = title;
    data['release_date'] = releaseDate;
    data['backdrop_path'] = backdropPath;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    return data;
  }
}
