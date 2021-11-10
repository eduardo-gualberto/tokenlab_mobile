import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StartButton extends StatefulWidget {
  final dynamic callback;

  StartButton({required this.callback});

  @override
  _StartButtonState createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {
  bool show_play = true;
  bool show_loading = false;

  void clickedPlay() {
    setState(() {
      this.show_play = false;
      this.show_loading = true;
    });
    widget.callback();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        show_play
            ? Column(
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
              )
            : Container(),
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
      ],
    );
  }
}
