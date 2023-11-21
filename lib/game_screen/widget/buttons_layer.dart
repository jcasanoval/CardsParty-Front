import 'package:cards_party/app/app.dart';
import 'package:cards_party/game_screen/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rules_repository/rules_repository.dart';

class ButtonsLayer extends StatelessWidget {
  const ButtonsLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RulesCubit, RulesState>(
      builder: (context, state) {
        if (state is! RulesLoaded) {
          return const SizedBox.shrink();
        }

        final buttons =
            state.uiElements.whereType<GameRuleWrapper<Button>>().toList();

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: buttons
                .map(
                  (wrapper) => ElevatedButton(
                    onPressed: wrapper.result.enabled
                        ? () => context.read<RulesCubit>().executeRule(
                              wrapper.rule,
                              context.read<AuthCubit>().currentUser.id,
                            )
                        : null,
                    child: Text(
                      wrapper.result.buttonLabel,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                )
                .toList(growable: false),
          ),
        );
      },
    );
  }
}
