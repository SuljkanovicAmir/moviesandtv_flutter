class MovieEntity {
  final String posterPath;
  final int id;
  final String backdropPath;
  final String title;
  final String? voteAverage;
  final String releaseDate;
  final String name;

  MovieEntity({
    required this.posterPath,
    required this.id,
    required this.backdropPath,
    required this.title,
    this.voteAverage,
    required this.releaseDate,
    required this.name,
  });
}
