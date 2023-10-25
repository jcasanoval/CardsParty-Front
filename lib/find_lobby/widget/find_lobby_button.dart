import 'package:cards_party/app/app.dart';
import 'package:cards_party/find_lobby/cubit/find_lobby_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lobby_repository/lobby_repository.dart';

class FindLobbyButton extends StatelessWidget {
  const FindLobbyButton({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Find Lobby'),
      onPressed: () {
        final currentUser = context.read<AuthCubit>().currentUser;
        context.read<FindLobbyCubit>().joinByGameCode(
              controller.text,
              LobbyPlayer(id: currentUser.id, name: currentUser.name),
            );
      },
    );
  }
}
