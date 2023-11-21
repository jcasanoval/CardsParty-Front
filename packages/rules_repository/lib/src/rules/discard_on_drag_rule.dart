import 'package:game_repository/game_repository.dart';
import 'package:rules_repository/rules_repository.dart';

class DiscardOnDragRule extends CardRuleContract {
  const DiscardOnDragRule() : super(priority: 0);

  @override
  Game applyRule(String userId, Game gameState, Card card) {
    for (final player in gameState.players) {
      if (player.id == userId) {
        player.cards.remove(card);
      }

      gameState.discardPile.add(card);
    }

    return gameState;
  }

  @override
  CardAction? conditionMet(String userId, Game gameState, Card card) {
    if (gameState.players
        .firstWhere((player) => player.id == userId)
        .cards
        .contains(card)) {
      return Drag(enabled: true);
    }
    return null;
  }
}
