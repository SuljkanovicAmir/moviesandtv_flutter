class Details {
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;

  Details({
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.posterPath,
  });

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
        title: json['title'],
        overview: json['overview'],
        releaseDate: json['release_date'],
        posterPath: json['poster_path']);
  }
}

class TopMovies {
  final int id;
  final String posterPath;

  TopMovies({
    required this.id,
    required this.posterPath,
  });

  factory TopMovies.fromJson(Map<String, dynamic> json) {
    return TopMovies(id: json['id'], posterPath: json['poster_path']);
  }
}

class UpcomingMovies {
  final int id;
  final String backdropPath;
  final String releaseDate;
  final String title;

  UpcomingMovies(
      {required this.id,
      required this.backdropPath,
      required this.releaseDate,
      required this.title});

  factory UpcomingMovies.fromJson(Map<String, dynamic> json) {
    return UpcomingMovies(
        id: json['id'],
        backdropPath: json['poster_path'],
        releaseDate: json['release_date'],
        title: json['title']);
  }
}
