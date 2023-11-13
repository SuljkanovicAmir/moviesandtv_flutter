class MovieDetailEntity {
  final int id;
  final String title;
  final String? overview;
  final String? releaseDate;
  final String? voteAverage;
  final String? backdropPath;
  final String posterPath;

  const MovieDetailEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.backdropPath,
    required this.posterPath,
  });
}
