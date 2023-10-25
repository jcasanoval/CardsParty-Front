import 'package:cards_party/app/app.dart';
import 'package:cards_party/find_lobby/find_lobby.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lobby_repository/lobby_repository.dart';

class CreateLobbyButton extends StatelessWidget {
  const CreateLobbyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Create Lobby'),
      onPressed: () async {
        final currentUser = context.read<AuthCubit>().currentUser;
        await context.read<FindLobbyCubit>().createLobby(
              LobbyPlayer(id: currentUser.id, name: currentUser.name),
            );
      },
    );
  }
}
