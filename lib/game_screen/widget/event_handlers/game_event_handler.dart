import 'package:cards_party/app/app.dart';
import 'package:cards_party/game_screen/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameEventHandler extends StatelessWidget {
  const GameEventHandler({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameCubit, GameState>(
      listener: (context, state) {
        if (state is! GameLoaded) {
          return;
        }

        final rulesCubit = context.read<RulesCubit>();
        final rulesState = rulesCubit.state;

        if (rulesState is RulesInitial) {
          context.read<RulesCubit>().init('rulesetId');
        } else if (rulesState is RulesLoaded) {
          final user = context.read<AuthCubit>().currentUser;
          rulesCubit.updateGameState(
            state.game,
            user.id,
          );
        }
      },
      child: child,
    );
  }
}
