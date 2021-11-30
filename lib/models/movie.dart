class Movie {
  final String imdbID;
  final String poster;
  final String title;
  final String year;

  Movie({
    required this.imdbID,
    required this.poster,
    required this.title,
    required this.year,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      imdbID: json["imdbID"],
      poster: json["Poster"],
      title: json["Title"],
      year: json["Year"],
    );
  }
}
