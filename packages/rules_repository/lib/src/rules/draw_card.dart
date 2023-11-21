import 'dart:math';

import 'package:game_repository/game_repository.dart';
import 'package:rules_repository/rules_repository.dart';

class DrawCard extends GameRuleContract {
  const DrawCard();

  @override
  Game applyRule(String userId, Game gameState) {
    final card = Card(
      number: Random().nextInt(11),
      suit: Suit.values[Random().nextInt(4)],
    );
    final player =
        gameState.players.firstWhere((player) => player.id == userId);
    player.cards.add(card);
    return gameState;
  }

  @override
  UIElement? conditionMet(String userId, Game gameState) {
    return Button(
      showButton: true,
      buttonLabel: 'Draw card!',
      color: ButtonColor.yellow,
      size: ButtonSize.medium,
      type: ButtonType.rounded,
      enabled: true,
    );
  }
}
