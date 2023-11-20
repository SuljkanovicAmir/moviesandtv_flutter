import 'package:moviesandtv_flutter/src/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  @override
  final int id;
  @override
  final String title;
  @override
  final String releaseDate;
  @override
  final String posterPath;
  @override
  final String? voteAverage;
  @override
  final String backdropPath;
  @override
  final String name;

  MovieModel({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.posterPath,
    required this.backdropPath,
    this.voteAverage,
    required this.name,
  }) : super(
          id: id,
          title: title,
          posterPath: posterPath,
          backdropPath: backdropPath,
          releaseDate: releaseDate,
          voteAverage: voteAverage,
          name: name,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        id: json['id'],
        title: json['title'] ?? '',
        name: json['name'] ?? '',
        voteAverage: json['vote_average']?.toStringAsFixed(1) ?? '0.0',
        releaseDate: json['release_date'] ?? json['first_air_date'] ?? '',
        posterPath: json['poster_path'] ?? '',
        backdropPath: json['backdrop_path'] ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vote_average'] = voteAverage;
    data['title'] = title;
    data['release_date'] = releaseDate;
    data['backdrop_path'] = backdropPath;
    data['poster_path'] = posterPath;
    return data;
  }
}
