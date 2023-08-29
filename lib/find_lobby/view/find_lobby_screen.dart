import 'package:auto_route/auto_route.dart';
import 'package:cards_party/bootstrap.dart';
import 'package:cards_party/find_lobby/find_lobby.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cards_party/l10n/l10n.dart';
import 'package:lobby_repository/lobby_repository.dart';

@RoutePage()
class FindLobbyScreen extends StatelessWidget {
  const FindLobbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FindLobbyCubit(),
      child: FindLobbyView(),
    );
  }
}

class FindLobbyView extends StatelessWidget {
  FindLobbyView({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text('Find lobby')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter lobby code',
              ),
              maxLength: 4,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[A-Z]')),
              ],
            ),
            TextButton(
              child: Text('Find Lobby'),
              onPressed: () async {
                try {
                  final lobby = await getIt<LobbyRepositoryContract>()
                      .joinLobbyByGamecode(_controller.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Found lobby with code ${lobby.gameCode} and id ${lobby.id}'),
                    ),
                  );
                } on LobbyException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.message),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Unknown error occurred while joining lobby'),
                    ),
                  );
                }
              },
            ),
            TextButton(
              child: Text('Create Lobby'),
              onPressed: () async {
                final lobby =
                    await getIt<LobbyRepositoryContract>().createLobby();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Created lobby with code ${lobby.gameCode}'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
