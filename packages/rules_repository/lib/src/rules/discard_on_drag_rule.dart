import 'package:game_repository/game_repository.dart';
import 'package:rules_repository/rules_repository.dart';

class DiscardOnDragRule implements CardRuleContract {
  @override
  Game applyRule(String userId, Game gameState, Card card) {
    if (conditionMet(userId, gameState, card) != null) {
      for (var player in gameState.players) {
        if (player.id == userId) {
          player.cards.remove(card);
        }

        gameState.discardPile.add(card);
      }
    }

    return gameState;
  }

  @override
  CardAction? conditionMet(String userId, Game gameState, Card card) {
    for (var player in gameState.players) {
      if (player.id == userId) {
        if (player.cards.every((c) => c == card)) {
          return Drag(enabled: true);
        }
      }
    }
  }
  
  @override
  int get priority => throw UnimplementedError();
}
