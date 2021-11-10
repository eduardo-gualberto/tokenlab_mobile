class Movie {
  final int id;
  final double vote_average;
  final String title;
  final String poster_url;
  final List<dynamic> genres;
  final String release_date;

  Movie(
      {required this.id,
        required this.vote_average,
        required this.title,
        required this.poster_url,
        required this.genres,
        required this.release_date});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        vote_average: json['vote_average'],
        title: json['title'],
        poster_url: json['poster_url'],
        genres: json['genres'],
        release_date: json['release_date']);
  }
}
