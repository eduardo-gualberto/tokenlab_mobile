import 'package:desafio_tokenlab/Pages/MovieDetailPage/MovieDetailPage.dart';
import 'package:flutter/material.dart';
import '../../../Models/MovieModel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MovieCard extends StatelessWidget {
  late String title;
  late String imgUrl;
  late double rating;
  late Movie movie;

  MovieCard(Movie movie) {
    this.movie = movie;
    this.title = movie.title;
    this.imgUrl = movie.poster_url;
    this.rating = movie.vote_average;
  }

  @override
  Widget build(BuildContext context) {
    //no caso de click/tap no widget, abrir tela MovieDetailPage
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetailPage(movie: this.movie)));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              //caso falhe em carregar é substituida pela imagem de erro
              child: Image.network(
                this.imgUrl,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset('lib/assets/200x300.jpg');
                },
                width: 200,
                height: 300,
                //enquanto carrega, mostra um circulo rodando
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
              height: 5,
            ),
            Center(
              child: Text(
                this.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
