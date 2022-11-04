import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  const MyBall({this.x, this.y, required this.gameHasStarted});
  final x;
  final y;
  final bool gameHasStarted;

  @override
  Widget build(BuildContext context) {
    return gameHasStarted
        ? Container(
            alignment: Alignment(x, y),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              width: 14,
              height: 14,
            ),
          )
        : Container(
            alignment: Alignment(x, y),
            child: AvatarGlow(
              endRadius: 50.0,
              child: Material(
                elevation: 8.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade100,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ),
          );
  }
}
