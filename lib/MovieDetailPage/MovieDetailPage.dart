import 'package:desafio_tokenlab/Models/MovieModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MovieDetailPage extends StatelessWidget {
  MovieDetailPage({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          movie.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 30,
            ),
            SizedBox(
              child: Image.network(
                this.movie.poster_url,
                scale: .75,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    'lib/assets/200x300.jpg',
                    scale: .75,
                  );
                },
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: SpinKitRing(
                      color: Colors.blue,
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  movie.title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 20,
                ),
                Text(
                  "${movie.vote_average}",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                )
              ],
            ),
            Container(
              height: 20,
            ),
            Center(
              child: Text(
                "Genres:",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  this.movie.genres.length,
                  (index) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          this.movie.genres[index],
                          style: TextStyle(fontSize: 18),
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
