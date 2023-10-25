import 'package:auto_route/auto_route.dart';
import 'package:cards_party/app/app.dart';
import 'package:cards_party/lobby_screen/lobby_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      create: (_) => LobbyScreenCubit()..loadLobby(lobbyId),
      child: const LobbyView(),
    );
  }
}

class LobbyView extends StatelessWidget {
  const LobbyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lobby')),
      body: BlocConsumer<LobbyScreenCubit, LobbyScreenState>(
        listener: (context, state) {
          if (state is GameStarted) {
            Future.delayed(Duration(seconds: 2), () {
              context.router.replace(
                CounterRoute(
                  gameId: state.lobby.id,
                ),
              );
            });
          }
        },
        builder: (context, state) {
          switch (state) {
            case LobbyScreenInitial():
              return const Center(child: CircularProgressIndicator());
            case LobbyLoaded():
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Lobby code: ${state.lobby.gameCode}'),
                    Text('Lobby id: ${state.lobby.id}'),
                    const StartGameButton(),
                  ],
                ),
              );
            case LobbyScreenError():
              return Center(
                child: Text(state.message),
              );
            case GameStarted():
              return const Center(
                child: Text('Game starting...'),
              );
          }
        },
      ),
    );
  }
}
