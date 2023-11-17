import 'dart:math';

import 'package:cards_party/game_screen/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerHandsLayer extends StatelessWidget {
  const PlayerHandsLayer({super.key});

  @override
  Widget build(BuildContext context) {
    final players =
        (context.watch<GameCubit>().state as GameLoaded).game.players;

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        // TODO(jcasanoval): Display correct players
        Positioned(
          bottom: 0,
          child: PlayerHand(
            player: players[0],
          ),
        ),
        Positioned(
          top: 0,
          child: PlayerHand(
            player: players[0],
            rotation: pi,
            rotateText: true,
          ),
        ),
        Positioned(
          left: 0,
          child: PlayerHand(
            player: players[0],
            rotation: pi / 2,
          ),
        ),
        Positioned(
          right: 0,
          child: PlayerHand(
            player: players[0],
            rotation: pi * 3 / 2,
          ),
        ),
      ],
    );
  }
}
