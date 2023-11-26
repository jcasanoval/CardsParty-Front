import 'package:cards_party/app/app.dart';
import 'package:cards_party/game_screen/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayingCard extends StatefulWidget {
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
  State<PlayingCard> createState() => _PlayingCardState();
}

class _PlayingCardState extends State<PlayingCard> {
  Offset offset = Offset.zero;

  double dragDistance = 300;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        dragDistance = MediaQuery.sizeOf(context).height / 3;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final card = widget.cardRule.card;
    final cardWidget = DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.black),
      child: Container(
        width: PlayingCard.width,
        height: PlayingCard.height,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: offset.distance > dragDistance ? Colors.yellow : Colors.grey,
            width: offset.distance > dragDistance ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            '${card.number.charIcon}\n${card.suit.charIcon}',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    if (!widget.cardRule.result.enabled) {
      return cardWidget;
    }

    return Draggable(
      feedback: Transform.rotate(
        angle: 0.1 + widget.parentRotation,
        child: Transform.scale(
          scale: 1.3,
          child: cardWidget,
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.1,
        child: cardWidget,
      ),
      onDragUpdate: (details) => setState(() {
        offset += details.delta;
        if (offset.distance > 100) {
          offset;
        }
      }),
      onDragStarted: () {},
      onDragEnd: (details) {
        if (offset.distance > dragDistance) {
          context.read<RulesCubit>().executeRule(
                widget.cardRule.rule,
                context.read<AuthCubit>().currentUser.id,
                card,
              );
        }
        setState(() {
          offset = Offset.zero;
        });
      },
      child: cardWidget,
    );
  }
}

extension CardValue on int {
  String get charIcon {
    switch (this) {
      case 1:
        return 'A';
      case 11:
        return 'J';
      case 12:
        return 'Q';
      case 13:
        return 'K';
      default:
        return toString();
    }
  }
}
