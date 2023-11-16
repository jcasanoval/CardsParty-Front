import 'package:cards_party/app/app.dart';
import 'package:cards_party/game_screen/game_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RulesInitializerHandler extends StatelessWidget {
  const RulesInitializerHandler({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RulesCubit, RulesState>(
      listenWhen: (previous, current) =>
          previous is RulesLoading && current is RulesLoaded,
      listener: (context, state) {
        if (state is RulesLoaded) {
          final gameState = context.read<GameCubit>().state;
          final userId = context.read<AuthCubit>().currentUser.id;

          if (gameState is GameLoaded) {
            context.read<RulesCubit>().updateGameState(
                  gameState.game,
                  userId,
                );
          }
        }
      },
      child: child,
    );
  }
}
