import 'package:cards_party/game_screen/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:game_repository/game_repository.dart';

class PlayerHand extends StatelessWidget {
  const PlayerHand({
    required this.player,
    this.rotation = 0,
    this.rotateText = false,
    super.key,
  });

  final Player player;

  final double rotation;

  final bool rotateText;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Column(
        children: [
          Transform.rotate(
            angle: rotateText ? -rotation : 0,
            child: Text(player.name),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PlayingCard(
                parentRotation: rotation,
              ),
              PlayingCard(
                parentRotation: rotation,
              ),
              PlayingCard(
                parentRotation: rotation,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
