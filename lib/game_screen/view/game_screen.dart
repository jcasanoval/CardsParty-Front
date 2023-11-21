import 'package:auto_route/auto_route.dart';
import 'package:cards_party/game_screen/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';
import 'package:rules_repository/rules_repository.dart';

@RoutePage()
class GameScreen extends StatelessWidget {
  const GameScreen({
    required this.gameId,
    super.key,
  });

  final String gameId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GameCubit(context.read<GameRepositoryContract>())
            ..listenToGame(gameId),
        ),
        BlocProvider(
          create: (context) => RulesCubit(
            gameId: gameId,
            rulesRepository: context.read<RulesRepositoryContract>(),
            gameRepository: context.read<GameRepositoryContract>(),
          ),
        ),
      ],
      child: const GameView(),
    );
  }
}

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GameEventHandler(
          child: RulesInitializerHandler(
            child: BlocBuilder<GameCubit, GameState>(
              builder: (context, state) {
                return switch (state) {
                  GameLoading() => const Center(
                      child: TaggedProgressIndicator(
                        tag: 'Joining game',
                      ),
                    ),
                  GameLoaded() => BlocBuilder<RulesCubit, RulesState>(
                      builder: (context, state) {
                        return switch (state) {
                          RulesLoading() || RulesInitial() => const Center(
                              child: TaggedProgressIndicator(
                                tag: 'Loading rules',
                              ),
                            ),
                          _ => const Stack(
                              fit: StackFit.expand,
                              children: [
                                PlayerHandsLayer(),
                                ButtonsLayer(),
                              ],
                            ),
                        };
                      },
                    ),
                };
              },
            ),
          ),
        ),
      ),
    );
  }
}
