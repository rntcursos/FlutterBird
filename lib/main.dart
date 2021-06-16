import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Game(),
    );
  }
}

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  bool startgame = false;

  int img = 0;
  double posy = 0;
  double posx = 0;

  int limit = 1;

  fly_animation() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        img += 1;
        if (img >= 4) {
          img = 0;
        }

        if (startgame == false) {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double sizex = MediaQuery.of(context).size.width;
    double sizey = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        if (startgame == false) {
          fly_animation();
          startgame = true;
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              "assets/sky.png",
              width: sizex,
              height: sizey,
              fit: BoxFit.fill,
            ),
            Objs(0, 1, "assets/ground.png"),
            Objs(0, posy, "assets/bird" + img.toString() + ".png")
          ],
        ),
      ),
    );
  }
}

class Objs extends StatefulWidget {
  double x = 0.0;
  double y = 0.0;
  String img = "assets/ground.png";

  Objs(this.x, this.y, this.img);

  @override
  State<Objs> createState() => _ObjsState();
}

class _ObjsState extends State<Objs> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: Alignment(widget.x, widget.y),
      duration: Duration(milliseconds: 0),
      child: Image.asset(
        widget.img,
      ),
    );
  }
}
