import 'package:auto_route/auto_route.dart';
import 'package:cards_party/bootstrap.dart';
import 'package:cards_party/l10n/l10n.dart';
import 'package:cards_party/lobby/lobby.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lobby_repository/lobby_repository.dart';

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
      child: LobbyView(),
    );
  }
}

class LobbyView extends StatelessWidget {
  LobbyView({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text('Lobby')),
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
                      onPressed: () {},
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