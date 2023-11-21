import 'package:cards_party/app/app.dart';
import 'package:cards_party/game_screen/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayingCard extends StatelessWidget {
  const PlayingCard({
    required this.cardRule,
    super.key,
    this.parentRotation = 0,
  });

  static const double width = 57.1;

  static const double height = 88.9;

  final double parentRotation;

  final CardRuleWrapper cardRule;

  @override
  Widget build(BuildContext context) {
    final card = cardRule.card;
    final cardWidget = DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.black),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            '${card.number}\n${card.suit.charIcon}',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    if (!cardRule.result.enabled) {
      return cardWidget;
    }

    return Draggable(
      feedback: Transform.rotate(
        angle: 0.1 + parentRotation,
        child: Transform.scale(
          scale: 1.3,
          child: cardWidget,
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.1,
        child: cardWidget,
      ),
      onDragStarted: () {},
      onDragEnd: (details) {
        if (details.offset.distance > 100) {
          context.read<RulesCubit>().executeRule(
                cardRule.rule,
                context.read<AuthCubit>().currentUser.id,
                card,
              );
        }
      },
      child: cardWidget,
    );
  }
}
