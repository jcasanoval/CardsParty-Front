import 'package:cards_party/app/app.dart';
import 'package:cards_party/lobby_screen/lobby_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartGameButton extends StatelessWidget {
  const StartGameButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isHost =
        context.read<LobbyScreenCubit>().isHost(context.currentUser.id);
    if (isHost) {
      return TextButton(
        child: const Text('Start game'),
        onPressed: () => context.read<LobbyScreenCubit>().startGame(),
      );
    }
    return const Text('Waiting for host');
  }
}
