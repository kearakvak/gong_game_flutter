// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pong_game/ball.dart';
import 'package:pong_game/brick.dart';
import 'package:pong_game/brickMy.dart';
import 'package:pong_game/coverscreen.dart';
import 'package:pong_game/scorescreen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// ignore: constant_identifier_names
enum direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  //Player variables (bottom brick)
  double playerX = -0.2;
  double brickWidth = 0.4; //out of 2
  int playerScore = 0;

  //enemy variables (Top brick)
  double enemyX = -2;
  int enemyScore = 0;

  //Game settings
  bool gameHasStarted = false;

  //Ball variables
  double ballX = 0;
  double ballY = 0;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;

  void startGrame() {
    print("Ball: $ballX");
    print("BallY:$ballY");
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      //update direction
      updateDirection();

      //Move ball
      moveBall();

      //move enemy
      moveEnemy();

      //check if player is dead
      if (isPlayerDead()) {
        enemyScore++;
        timer.cancel();
        _showDialog(false);
      }
      if (isEnemyDead()) {
        playerScore++;
        timer.cancel();
        _showDialog(true);
      }
    });
    print(gameHasStarted);
  }

  bool isEnemyDead() {
    if (ballY <= -1) {
      return true;
    }
    return false;
  }

  void moveEnemy() {
    setState(() {
      enemyX = ballX;
    });
  }

  void _showDialog(bool enemyDied) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 52, 130, 219),
          title: Center(
            child: Text(
              enemyDied ? "PINK WIN" : "PURPLE WIN",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: resetGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  padding: EdgeInsets.all(7),
                  color: enemyDied
                      ? Color.fromARGB(255, 255, 60, 0)
                      : Colors.yellow.shade100,
                  child: Text(
                    "PLAY AGAIN",
                    style: TextStyle(
                      color: enemyDied
                          ? Colors.deepPurple.shade100
                          : Colors.pink.shade700,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      gameHasStarted = false;
      ballX = 0.01;
      ballY = 0.01;
      playerX = -0.2;
      enemyX = -2;
    });
  }

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void updateDirection() {
    setState(() {
      print("BallY:$ballY");
      print("BallX:$ballX");
      print("BallYDirection:$ballYDirection");
      print("BallXDirection: $ballXDirection");
      //update vertical direction
      if (ballY >= 0.9 && playerX + brickWidth >= ballX && playerX <= ballX)
      // if (ballY >= 0.9)
      {
        //Update vertical direction
        ballYDirection = direction.UP;
      } else if (ballY <= -0.9) {
        ballYDirection = direction.DOWN;
      }
      // update horizontal direction
      if (ballX >= 1) {
        ballXDirection = direction.LEFT;
      } else if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
    });
    print(ballXDirection);
  }

  void moveBall() {
    setState(() {
      //Vertical movement
      if (ballYDirection == direction.DOWN) {
        ballY += 0.01;
      } else if (ballYDirection == direction.UP) {
        ballY -= 0.01;
      }
      //Horizontal movement
      if (ballXDirection == direction.LEFT) {
        ballX -= 0.01;
      } else if (ballXDirection == direction.RIGHT) {
        ballX += 0.01;
      }
    });
    print("test2:$ballXDirection");
    print("PlayerX $playerX");
  }

  void moveLeft() {
    setState(() {
      if (!(playerX - 0.1 <= -1)) {
        playerX -= 0.2;
      }
    });
  }

  void moveRigth() {
    setState(() {
      if (!(playerX + brickWidth >= 1)) {
        playerX += 0.1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRigth();
        }
      },
      child: GestureDetector(
        onTap: startGrame,
        child: Scaffold(
          backgroundColor: Colors.grey.shade800,
          body: Center(
            child: Stack(
              children: [
                //tap to play
                CoverScreen(
                  gameHasStarted: gameHasStarted,
                ),
                //Score screen
                ScoreScreen(
                  GameHasStarted: gameHasStarted,
                  enemyScore: enemyScore,
                  playerScore: playerScore,
                ),
                // Top brick
                MyBrick(
                  brickWidth: brickWidth,
                  x: enemyX,
                  y: -0.9,
                  thisIsEnemy: true,
                ),

                //Bottom brick
                BrickMy(
                  brickWidth: brickWidth,
                  x: playerX,
                  y: 0.9,
                  thisIsEnemy: false,
                ),

                //Ball
                MyBall(
                  x: ballX,
                  y: ballY,
                  gameHasStarted: gameHasStarted,
                ),

                // Container(
                //   alignment: Alignment(playerX, 0.9),
                //   child: Container(
                //     width: 2,
                //     height: 20,
                //     color: Colors.red,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
