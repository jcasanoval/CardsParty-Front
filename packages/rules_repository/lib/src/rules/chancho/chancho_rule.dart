import 'package:game_repository/game_repository.dart';
import 'package:game_repository/src/models/game.dart';
import 'package:rules_repository/rules_repository.dart';

class ChanchoRule extends GameRuleContract {
  const ChanchoRule() : super(priority: 1);

  @override
  Game applyRule(String userId, Game gameState) {
    final player =
        gameState.players.firstWhere((player) => player.id == userId);
    player.customParams['chancho'] = true;
    final unchanchoed = gameState.players
        .where((player) => player.customParams['chancho'] == null);
    if (unchanchoed.length == 1) {
      unchanchoed.first.score = unchanchoed.first.score! + 1;
      for (final player in gameState.players) {
        player.customParams['chancho'] = null;
        gameState.deck.addAll(player.cards);
        player.cards.clear();
        gameState.customParams['state'] = 'RoundStart';
      }
      gameState.deck.shuffle();
    }
    return gameState;
  }

  @override
  UIElement? conditionMet(String userId, Game gameState) {
    final player =
        gameState.players.firstWhere((player) => player.id == userId);
    final state = gameState.customParams['state'] as String? ?? 'RoundStart';
    if (state == 'RoundInProgress' &&
        player.cards.every((card) => card.number == player.cards[0].number)) {
      return Button(
        showButton: true,
        buttonLabel: 'Chancho!',
        color: ButtonColor.red,
        size: ButtonSize.medium,
        type: ButtonType.rounded,
        enabled: true,
      );
    }
    return null;
  }
}
