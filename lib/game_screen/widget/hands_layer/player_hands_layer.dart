import 'package:cards_party/app/app.dart';
import 'package:cards_party/game_screen/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';

class PlayerHandsLayer extends StatelessWidget {
  const PlayerHandsLayer({super.key});

  @override
  Widget build(BuildContext context) {
    final players = sinkCurrentPlayerToBottom(
      (context.watch<GameCubit>().state as GameLoaded).game.players,
      context.read<AuthCubit>().currentUser.id,
    );

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Positioned(
          bottom: 0,
          child: PlayerHand(
            player: players[0],
          ),
        ),
        if (players.length == 2 || players.length == 4)
          Positioned(
            top: 0,
            child: PlayerHand(
              player: players.length == 2 ? players[1] : players[2],
              quarterTurns: 2,
              rotateText: true,
            ),
          ),
        if (players.length == 3 || players.length == 4)
          Positioned(
            left: 0,
            child: PlayerHand(
              player: players.length == 3 ? players[2] : players[3],
              quarterTurns: 1,
            ),
          ),
        if (players.length == 3 || players.length == 4)
          Positioned(
            right: 0,
            child: PlayerHand(
              player: players[1],
              quarterTurns: 3,
            ),
          ),
      ],
    );
  }

  List<Player> sinkCurrentPlayerToBottom(List<Player> players, String userId) {
    final clonedPlayers = List<Player>.from(players);
    while (clonedPlayers[0].id != userId) {
      final currentPlayer = clonedPlayers.removeAt(0);
      clonedPlayers.add(currentPlayer);
    }
    return clonedPlayers;
  }
}
