import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const _MyApp(),
  );
}

class _MyApp extends StatelessWidget {
  const _MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        canvasColor: Colors.blue,
      ),
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
  int image = 0;
  int fps = 0;

  static int score = 0;

  static double birdy = 0;
  double grav = 0.1;

  double time = 0;
  double height = 0;
  double initHeight = birdy;

  bool gamestart = false;

  static double pipePosx = 2;
  static double pipePosy = 3;

  void fly() {
    setState(() {
      time = 0;
      initHeight = birdy;
    });
  }

  void animated() {
    if (gamestart) {
      setState(() {
        fps += 1;
        if (fps >= 60) {
          fps = 0;
          image += 1;
        }

        if (image >= 4) {
          image = 0;
        }
      });
    }
  }

  void startGame() {
    gamestart = true;
    initHeight = birdy;

    Timer.periodic(Duration(microseconds: 1), (timer) {
      animated();
    });

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdy = initHeight - height;
        pipePosx -= 0.05;
      });
      if (birdy > 1) {
        timer.cancel();
        gamestart = false;
      }

      if (pipePosx <= -2) {
        pipePosx = 3;
        score += 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gamestart) {
          fly();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, birdy),
                      duration: Duration(milliseconds: 0),
                      child: Image.asset(
                          "assets/bird" + image.toString() + ".png"),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(pipePosx, pipePosy),
                      duration: Duration(milliseconds: 0),
                      child: Image.asset("assets/pipe1.png"),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(pipePosx, -pipePosy),
                      duration: Duration(milliseconds: 0),
                      child: Image.asset("assets/pipe2.png"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          gamestart ? "" : "TAP TO PLAY!",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Score:",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                              Text(
                                score.toString(),
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Best:",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                              Text(
                                "10",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
