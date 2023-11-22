import 'package:game_repository/src/models/game.dart';
import 'package:rules_repository/rules_repository.dart';

class ChanchoRule extends GameRuleContract {
  const ChanchoRule() : super(priority: 0);

  @override
  Game applyRule(String userId, Game gameState) {
    // TODO: implement applyRule
    throw UnimplementedError();
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
