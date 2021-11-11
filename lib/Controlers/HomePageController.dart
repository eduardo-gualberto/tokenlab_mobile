import 'dart:convert';
import 'package:desafio_tokenlab/Models/MovieModel.dart';
import 'package:http/http.dart' as http;

class HomePageController {
  List<Movie> movies = [];

  Future<List<Movie>> getMoviesFromNetwork() async {
    final http.Response response;
    try {
      response = await http.get(Uri.parse(
          "https://desafio-mobile.nyc3.digitaloceanspaces.com/movies"));
    } catch (e) {
      throw Exception();
    }

    print(response.statusCode);
    if (response.statusCode != 200) throw Exception();
    List<dynamic> raw_movies = jsonDecode(response.body);
    List<Movie> temp = [];
    for (var movie in raw_movies) temp.add(Movie.fromJson(movie));
    temp.sort((Movie a, Movie b) => a.vote_average.compareTo(b.vote_average));
    temp = new List.from(temp.reversed);
    this.movies = temp;
    return this.movies;
  }
}
