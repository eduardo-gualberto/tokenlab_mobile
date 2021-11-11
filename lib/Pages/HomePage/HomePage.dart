import 'package:desafio_tokenlab/Pages/HomePage/Widgets/StartButton.dart';
import '../../Models/MovieModel.dart';
import 'Widgets/MovieCard.dart';
import 'package:flutter/material.dart';
import '../../Controlers/HomePageController.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> movies = [];
  bool show_start = true;
  bool show_body = false;

  HomePageController controller = new HomePageController();

  Future<void> _getMoviesList() async {
    print("chamou");
    List<Movie> temp;
    try {
      temp = await this.controller.getMoviesFromNetwork();
    } catch (e) {
      throw Exception();
    }
    setState(() {
      this.movies = temp;
      this.show_start = false;
      this.show_body = true;
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
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 400));
          return _getMoviesList();
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                show_start
                    ? StartButton(callback: _getMoviesList)
                    : Container(),
                show_body
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
                show_body
                    ? GridView.count(
                        physics: ScrollPhysics(),
                        childAspectRatio: 2 / 3,
                        mainAxisSpacing: 1,
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        children: List.generate(movies.length,
                            (index) => Center(child: MovieCard(movies[index]))),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
