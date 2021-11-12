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
    //serviço para recuperar os dados de todos os filmes
    List<Movie> temp;
    try {
      temp = await this.controller.getMoviesFromNetwork();
    } catch (e) {
      //deve ocorrer quando o cliente nao tem conexão com internet e no StartButton
      throw Exception();
    }
    setState(() {
      //variaveis de controle de display que permitem transicionar entre um estado e outro
      //show_start controla a visibilidade de StartButton
      //show body controla a visibilidade de lista de filmes
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
      //RefreshIndicator para permitir gesto 'pull down refresh'
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 400));
          return _getMoviesList();
        },
        child: Center(
          //evitar pixel overflow e permitir scroll
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //a mensagem de erro de rede é exibida dentro de StartButton
                show_start
                    ? StartButton(callback: _getMoviesList)
                    : Container(),
                show_body
                    ? Column(
                        children: [
                          //titulo da pagina com divisor
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Text(
                                  "TMDB's most popular movies",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                Divider(
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                          //usa-se grid view para mostrar os elementos, pois permite que dois elementos
                          //estejam na mesma linha, como é o propósito do aplicativo
                          GridView.count(
                            physics: ScrollPhysics(),
                            childAspectRatio: 2 / 3,
                            mainAxisSpacing: 1,
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            children: List.generate(
                                movies.length,
                                (index) =>
                                //invoca o widget MovieCard passando o filme que ele é delegado representar
                                    Center(child: MovieCard(movies[index]))),
                          ),
                        ],
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
