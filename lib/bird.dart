import 'package:flutter/material.dart';
import 'dart:async';

class Bird extends StatefulWidget {
  const Bird({Key? key}) : super(key: key);

  @override
  _BirdState createState() => _BirdState();
}

class _BirdState extends State<Bird> {
  double posx = 0;
  double posy = 0;
  int img = 0;

  int time = 0;
  bool loop = true;

  timer() {
    time += 1;
    if (time >= 60) {
      time = 0;
      img += 1;
    }
  }

  imgUpdate() {
    if (img >= 4) {
      img = 0;
    }
  }

  grav() {
    posy += 0.1;
  }

  void update() {
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        timer;
        imgUpdate;
        grav;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 0),
      alignment: Alignment(posx, posy),
      child: Image.asset(
        "assets/bird" + img.toString() + ".png",
        width: 160,
        height: 160,
      ),
    );
  }
}
