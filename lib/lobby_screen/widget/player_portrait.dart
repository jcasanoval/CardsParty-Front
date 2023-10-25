import 'package:cards_party/lobby_screen/lobby_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lobby_repository/lobby_repository.dart';

class PlayerPortrait extends StatelessWidget {
  const PlayerPortrait({
    required this.player,
    super.key,
  });

  final LobbyPlayer player;

  @override
  Widget build(BuildContext context) {
    final isHost = context.read<LobbyScreenCubit>().isHost(player.id);
    return Row(
      children: [
        Icon(
          Icons.person,
          color: isHost ? Colors.yellow : null,
        ),
        const SizedBox(width: 8),
        Text(player.name),
      ],
    );
  }
}
