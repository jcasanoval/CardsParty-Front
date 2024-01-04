import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';
import 'package:rules_repository/rules_repository.dart';

class DealCardsRule extends GameRuleContract {
  const DealCardsRule() : super(priority: 1);

  @override
  Game applyRule(String userId, Game gameState) {
    for (final player in gameState.players) {
      while (player.cards.length < 4) {
        player.cards.add(gameState.deck.removeAt(0));
      }
    }

    gameState.customParams['state'] = 'RoundInProgress';

    return gameState;
  }

  @override
  UIElement? conditionMet(String userId, Game gameState) {
    final state = gameState.customParams['state'] as String? ?? 'RoundStart';
    if (state == 'RoundStart' && userId == gameState.hostId) {
      return Button(
        showButton: true,
        buttonLabel: 'Deal cards!',
        color: ButtonColor.yellow,
        size: ButtonSize.medium,
        type: ButtonType.rounded,
        enabled: true,
      );
    }
    return null;
  }
}

const dealCardsCustomRule = CustomGameRule(
  priority: 1,
  conditionMetExp: IfExp(
    condition: BoolComparatorStm(
      BoolComparator.equal,
      VariableStm('game.state'),
      LiteralStm('RoundStart'),
    ),
    then: IfExp(
      condition: BoolComparatorStm(
        BoolComparator.equal,
        VariableStm('currentPlayer.id'),
        VariableStm('game.hostId'),
      ),
      then: ReturnButtonExp(
        buttonLabel: LiteralStm('Deal cards!'),
        enabled: LiteralStm(true),
        showButton: LiteralStm(true),
        color: ButtonColor.yellow,
        size: ButtonSize.medium,
        type: ButtonType.rounded,
      ),
    ),
  ),
  applyRuleExp: BlockExp(
    expressions: [
      DealEachExp(amount: LiteralStm(4)),
      SetVariableExp(
        variableName: 'game.state',
        value: LiteralStm('RoundInProgress'),
      ),
    ],
  ),
);
