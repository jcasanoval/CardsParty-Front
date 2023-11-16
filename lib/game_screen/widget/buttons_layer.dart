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
            filterByType<UIElement, Button, GameRuleContract>(state.uiElements);

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: buttons.entries
                .map(
                  (entry) => ElevatedButton(
                    onPressed: entry.key.enabled
                        ? () => context.read<RulesCubit>().executeRule(
                              entry.value,
                              context.read<AuthCubit>().currentUser.id,
                            )
                        : null,
                    child: Text(
                      entry.key.buttonLabel,
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

Map<T, V> filterByType<K, T extends K, V>(Map<K, V> map) {
  return Map<T, V>.fromEntries(
    map.entries
        .where((entry) => entry.key is T)
        .map((entry) => MapEntry<T, V>(entry.key as T, entry.value)),
  );
}
