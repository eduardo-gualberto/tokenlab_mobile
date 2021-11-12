import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StartButton extends StatefulWidget {
  final dynamic callback;

  StartButton({required this.callback});

  @override
  _StartButtonState createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton>
    with SingleTickerProviderStateMixin {
  bool show_play = true;
  bool show_loading = false;
  bool req_error = false;

  late AnimationController _controller;
  late Animation<double> _animation;

  //setup necessário para animação da mensagem de errro
  @override
  void initState() {
    super.initState();
    this._controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(milliseconds: 500),
    );
    this._animation = Tween(begin: 0.0, end: 1.0).animate(this._controller);
    _controller.animateBack(0.0);
  }

  void clickedPlay() async {
    setState(() {
      //quando click em StartButton, esconder ele e mostrar o widget de 'carregando'
      this.show_play = false;
      this.show_loading = true;
    });
    try {
      await widget.callback();
    } catch (e) {
      //em caso de erro: mostrar widget de erro, começar sua animação e reverter os controles do inicio
      setState(() {
        this.req_error = true;
        this.show_play = true;
        this.show_loading = false;
      });
      _controller.forward();
      new Timer(Duration(seconds: 4), () {
        _controller.animateBack(0.0).then((value) {
          setState(() {
            this.req_error = false;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Botao clicável
        show_play
            ? SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: clickedPlay,
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
                ),
              )
            : Container(),
        //widget que indica 'carregando'
        show_loading
            ? Column(children: [
                SpinKitRing(
                  color: Colors.blue,
                ),
                Container(
                  height: 10,
                ),
                Center(
                  child: Text("Loading content..."),
                )
              ])
            : Container(),
        //widget de erro, aparece e dentro de 3s é removido novamente
        req_error
            ? FadeTransition(
                opacity: _animation,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    "Could not load content.\n Please try again later.",
                    style: TextStyle(fontSize: 18, color: Colors.deepOrange),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
