import 'package:auto_route/auto_route.dart';
import 'package:cards_party/app/app.dart';
import 'package:cards_party/bootstrap.dart';
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
        final lobby = await getIt<LobbyRepositoryContract>().createLobby(
          host: LobbyPlayer(id: currentUser.id, name: currentUser.name),
        );
        await context.router.push(
          LobbyRoute(lobbyId: lobby.id),
        );
      },
    );
  }
}
