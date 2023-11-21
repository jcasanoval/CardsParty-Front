import 'package:cards_party/game_screen/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';
import 'package:rules_repository/rules_repository.dart';

class PlayerHand extends StatelessWidget {
  const PlayerHand({
    required this.player,
    this.rotation = 0,
    this.rotateText = false,
    super.key,
  });

  final Player player;

  final double rotation;

  final bool rotateText;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Column(
        children: [
          Transform.rotate(
            angle: rotateText ? -rotation : 0,
            child: Text(player.name),
          ),
          BlocBuilder<RulesCubit, RulesState>(
            buildWhen: (previous, current) => current is RulesLoaded,
            builder: (context, state) {
              final cardRules = state is RulesLoaded
                  ? state.cardRules
                      .where((rule) => player.cards.contains(rule.card))
                      .toList(growable: false)
                  : <CardRuleWrapper<CardAction>>[];
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  cardRules.length,
                  (index) => PlayingCard(
                    parentRotation: rotation,
                    cardRule: cardRules[index],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
