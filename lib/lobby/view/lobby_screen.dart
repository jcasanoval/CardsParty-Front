import 'package:auto_route/auto_route.dart';
import 'package:cards_party/app/app.dart';
import 'package:cards_party/bootstrap.dart';
import 'package:cards_party/l10n/l10n.dart';
import 'package:cards_party/lobby/lobby.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';

@RoutePage()
class LobbyScreen extends StatelessWidget {
  const LobbyScreen({
    required this.lobbyId,
    super.key,
  });

  final String lobbyId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LobbyCubit()..loadLobby(lobbyId),
      child: const LobbyView(),
    );
  }
}

class LobbyView extends StatelessWidget {
  const LobbyView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: const Text('Lobby')),
      body: BlocBuilder<LobbyCubit, LobbyState>(
        builder: (context, state) {
          switch (state) {
            case LobbyInitial():
              return const Center(child: CircularProgressIndicator());
            case LobbyLoaded():
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Lobby code: ${state.lobby.gameCode}'),
                    Text('Lobby id: ${state.lobby.id}'),
                    TextButton(
                      child: const Text('Start game'),
                      onPressed: () {
                        getIt<GameRepositoryContract>()
                            .createGame(Game(id: state.lobby.id));
                        context.router
                            .push(CounterRoute(gameId: state.lobby.id));
                      },
                    ),
                  ],
                ),
              );
            case LobbyError():
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
