import 'package:auto_route/auto_route.dart';
import 'package:cards_party/app/app.dart';
import 'package:cards_party/bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:lobby_repository/lobby_repository.dart';

class FindLobbyButton extends StatelessWidget {
  const FindLobbyButton({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Find Lobby'),
      onPressed: () async {
        try {
          final lobby = await getIt<LobbyRepositoryContract>()
              .joinLobbyByGamecode(_controller.text);
          await context.router.push(
            LobbyRoute(lobbyId: lobby.id),
          );
        } on LobbyException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Unknown error occurred while joining lobby'),
            ),
          );
        }
      },
    );
  }
}
