import 'dart:convert';
import '../Models/MovieModel.dart';
import './Widgets/MovieCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> movies = [];
  bool show_play = true;

  void _getMoviesList() async {
    final http.Response response = await http.get(
        Uri.parse("https://desafio-mobile.nyc3.digitaloceanspaces.com/movies"));
    List<dynamic> raw_movies = jsonDecode(response.body);
    List<Movie> movies = [];
    for (var movie in raw_movies) movies.add(Movie.fromJson(movie));
    movies.sort((Movie a, Movie b) => a.vote_average.compareTo(b.vote_average));
    movies = new List.from(movies.reversed);
    setState(() {
      this.movies = movies;
      this.show_play = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        )),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              show_play
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: _getMoviesList,
                            child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.play_circle,
                                  size: 100,
                                )),
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                            ),
                          ),
                        ),
                        Text(
                          'Click to find the best movies',
                        ),
                      ],
                    )
                  : Container(),
              !show_play
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text(
                            "TMDB's most popular movies",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            color: Colors.black,
                          )
                        ],
                      ),
                    )
                  : Container(),
              GridView.count(
                physics: ScrollPhysics(),
                childAspectRatio: 2 / 3,
                mainAxisSpacing: 1,
                crossAxisCount: 2,
                shrinkWrap: true,
                children: List.generate(movies.length,
                    (index) => Center(child: MovieCard(movies[index]))),
              ),

              // ListView(
              //   children: []
              //
              // )
            ],
          ),
        ),
      ),
    );
  }
}
