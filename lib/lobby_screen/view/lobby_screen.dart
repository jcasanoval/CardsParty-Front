import 'package:auto_route/auto_route.dart';
import 'package:cards_party/app/app.dart';
import 'package:cards_party/lobby_screen/lobby_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';
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
      create: (context) => LobbyScreenCubit(
        lobbyRepository: context.read<LobbyRepositoryContract>(),
        gameRepository: context.read<GameRepositoryContract>(),
      )..loadLobby(lobbyId),
      child: const LobbyView(),
    );
  }
}

class LobbyView extends StatelessWidget {
  const LobbyView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final leave = await showDialog<bool>(
              context: context,
              builder: (_) => const _ConfirmLeaveDialog(),
            ) ??
            false;
        if (leave) {
          return context
              .read<LobbyScreenCubit>()
              .leaveLobby(context.currentUser.id);
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Lobby')),
        body: BlocConsumer<LobbyScreenCubit, LobbyScreenState>(
          listener: (context, state) {
            if (state is GameStarted) {
              Future.delayed(const Duration(seconds: 2), () {
                context.router.replace(
                  // CounterRoute(
                  //   gameId: state.lobby.id,
                  // ),
                  GameRoute(
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
                      ...state.lobby.players
                          .map((player) => PlayerPortrait(player: player)),
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
      ),
    );
  }
}

class _ConfirmLeaveDialog extends StatelessWidget {
  const _ConfirmLeaveDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Leave lobby'),
      actions: [
        TextButton(
          child: const Text('No'),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextButton(
          child: const Text('Yes'),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
      content: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        child: const Text('Are you sure you want to leave the lobby?'),
      ),
    );
  }
}
