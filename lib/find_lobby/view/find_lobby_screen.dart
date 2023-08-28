import 'package:auto_route/auto_route.dart';
import 'package:cards_party/bootstrap.dart';
import 'package:cards_party/find_lobby/find_lobby.dart';
import 'package:flutter/material.dart';
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
      child: const FindLobbyView(),
    );
  }
}

class FindLobbyView extends StatelessWidget {
  const FindLobbyView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text('Find lobby')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Find Lobby'),
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
