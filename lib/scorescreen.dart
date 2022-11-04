import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen(
      {required this.GameHasStarted, this.enemyScore, this.playerScore});
  final bool GameHasStarted;
  final enemyScore;
  final playerScore;
  @override
  Widget build(BuildContext context) {
    return GameHasStarted
        ? Stack(
            children: [
              Container(
                alignment: Alignment(0, 0),
                child: Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width / 4,
                  color: Colors.grey.shade300,
                ),
              ),
              Container(
                alignment: Alignment(0, -0.3),
                child: Container(
                  child: Text(
                    enemyScore.toString(),
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 100,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment(0, 0.3),
                child: Text(
                  playerScore.toString(),
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 100,
                  ),
                ),
              ),
            ],
          )
        : Container();
  }
}
