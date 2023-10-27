import 'package:auto_route/auto_route.dart';
import 'package:cards_party/game_screen/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class GameScreen extends StatelessWidget {
  const GameScreen({
    required this.gameId,
    super.key,
  });

  final String gameId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameCubit()..listenToGame(gameId),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          return switch (state) {
            GameLoading() => const Center(child: CircularProgressIndicator()),
            GameLoaded() => const Center(child: Text('Game loaded!')),
          };
        },
      ),
    );
  }
}
