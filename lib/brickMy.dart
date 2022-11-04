import 'package:flutter/material.dart';

class BrickMy extends StatelessWidget {
  const BrickMy(
      {required this.x, required this.y, this.brickWidth, this.thisIsEnemy});
  final x;
  final y;
  final brickWidth; // out of 2
  final thisIsEnemy;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * x + brickWidth) / (2 - brickWidth), y),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: thisIsEnemy
              ? Colors.blue.shade400
              : Color.fromARGB(255, 222, 233, 185),
          height: 20,
          width: MediaQuery.of(context).size.width * brickWidth / 2,
        ),
      ),
    );
  }
}
