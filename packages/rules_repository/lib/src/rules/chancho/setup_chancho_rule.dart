import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';
import 'package:rules_repository/rules_repository.dart';

class SetupChanchoRule extends GameRuleContract {
  const SetupChanchoRule() : super(priority: 0);

  @override
  Game applyRule(String userId, Game gameState) {
    final cards = <Card>[];
    var i = 1;
    for (final player in gameState.players) {
      cards
        ..add(Card(number: i, suit: Suit.club))
        ..add(Card(number: i, suit: Suit.diamond))
        ..add(Card(number: i, suit: Suit.heart))
        ..add(Card(number: i, suit: Suit.spade));
      i++;
      player.score = 0;
    }

    cards.shuffle();

    gameState.deck.addAll(cards);

    gameState
      ..customParams['started'] = true
      ..customParams['state'] = 'RoundStart';

    return gameState;
  }

  @override
  UIElement? conditionMet(String userId, Game gameState) {
    final started = gameState.getProperty('started') as bool? ?? false;
    if (!started) {
      return Button(
        showButton: true,
        buttonLabel: 'Start game!',
        color: ButtonColor.green,
        size: ButtonSize.medium,
        type: ButtonType.rounded,
        enabled: true,
      );
    }
    return null;
  }
}

const setupChanchoCustomRule = CustomGameRule(
  priority: 0,
  conditionMetExp: IfExp(
    condition: BoolComparatorStm(
        BoolComparator.equal, VariableStm('game.started'), LiteralStm(null)),
    then: ReturnButtonExp(
      buttonLabel: LiteralStm('Start game!'),
      color: ButtonColor.green,
      enabled: LiteralStm(true),
      showButton: LiteralStm(true),
      size: ButtonSize.medium,
      type: ButtonType.rounded,
    ),
  ),
  applyRuleExp: BlockExp(
    expressions: [
      SetVariableExp(
        variableName: 'iterator',
        value: LiteralStm(0),
      ),
      WhileExp(
        condition: BoolComparatorStm(
          BoolComparator.lessThan,
          VariableStm('iterator'),
          VariableStm('game.playerCount'),
        ),
        body: BlockExp(
          expressions: [
            SetScoreExp(
              value: LiteralStm(0),
              playerIndex: VariableStm('iterator'),
            ),
            SetVariableExp(
              variableName: 'card',
              value: CardStm(
                number: VariableStm('iterator'),
                suit: Suit.club,
              ),
            ),
            AddCardExp(card: VariableStm('card')),
            DiscardExp(discard: VariableStm('card'), deck: LiteralStm(true)),
            SetVariableExp(
              variableName: 'card',
              value: CardStm(
                number: VariableStm('iterator'),
                suit: Suit.diamond,
              ),
            ),
            AddCardExp(card: VariableStm('card')),
            DiscardExp(discard: VariableStm('card'), deck: LiteralStm(true)),
            SetVariableExp(
              variableName: 'card',
              value: CardStm(
                number: VariableStm('iterator'),
                suit: Suit.heart,
              ),
            ),
            AddCardExp(card: VariableStm('card')),
            DiscardExp(discard: VariableStm('card'), deck: LiteralStm(true)),
            SetVariableExp(
              variableName: 'card',
              value: CardStm(
                number: VariableStm('iterator'),
                suit: Suit.spade,
              ),
            ),
            AddCardExp(card: VariableStm('card')),
            DiscardExp(discard: VariableStm('card'), deck: LiteralStm(true)),
            SetVariableExp(
              variableName: 'iterator',
              value: MathStm(
                VariableStm('iterator'),
                MathOperator.add,
                LiteralStm(1),
              ),
            ),
          ],
        ),
      ),
      ShuffleExp(),
      SetVariableExp(
        variableName: 'game.started',
        value: LiteralStm(true),
      ),
      SetVariableExp(
        variableName: 'game.state',
        value: LiteralStm('RoundStart'),
      ),
    ],
  ),
);
