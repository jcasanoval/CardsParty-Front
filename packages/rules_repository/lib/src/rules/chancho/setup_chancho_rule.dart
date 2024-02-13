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
  conditionMetExp: IfStm(
    condition: BoolComparatorExp(
        BoolComparator.equal, VariableExp('game.started'), LiteralExp(null)),
    then: ReturnButtonStm(
      buttonLabel: LiteralExp('Start game!'),
      color: ButtonColor.green,
      enabled: LiteralExp(true),
      showButton: LiteralExp(true),
      size: ButtonSize.medium,
      type: ButtonType.rounded,
    ),
  ),
  applyRuleExp: BlockStm(
    expressions: [
      SetVariableStm(
        variableName: 'iterator',
        value: LiteralExp(0),
      ),
      WhileStm(
        condition: BoolComparatorExp(
          BoolComparator.lessThan,
          VariableExp('iterator'),
          VariableExp('game.playerCount'),
        ),
        body: BlockStm(
          expressions: [
            SetScoreStm(
              value: LiteralExp(0),
              playerIndex: VariableExp('iterator'),
            ),
            SetVariableStm(
              variableName: 'card',
              value: CardExp(
                number: VariableExp('iterator'),
                suit: Suit.club,
              ),
            ),
            AddCardStm(card: VariableExp('card')),
            DiscardStm(discard: VariableExp('card'), deck: LiteralExp(true)),
            SetVariableStm(
              variableName: 'card',
              value: CardExp(
                number: VariableExp('iterator'),
                suit: Suit.diamond,
              ),
            ),
            AddCardStm(card: VariableExp('card')),
            DiscardStm(discard: VariableExp('card'), deck: LiteralExp(true)),
            SetVariableStm(
              variableName: 'card',
              value: CardExp(
                number: VariableExp('iterator'),
                suit: Suit.heart,
              ),
            ),
            AddCardStm(card: VariableExp('card')),
            DiscardStm(discard: VariableExp('card'), deck: LiteralExp(true)),
            SetVariableStm(
              variableName: 'card',
              value: CardExp(
                number: VariableExp('iterator'),
                suit: Suit.spade,
              ),
            ),
            AddCardStm(card: VariableExp('card')),
            DiscardStm(discard: VariableExp('card'), deck: LiteralExp(true)),
            SetVariableStm(
              variableName: 'iterator',
              value: MathExp(
                VariableExp('iterator'),
                MathOperator.add,
                LiteralExp(1),
              ),
            ),
          ],
        ),
      ),
      ShuffleStm(),
      SetVariableStm(
        variableName: 'game.started',
        value: LiteralExp(true),
      ),
      SetVariableStm(
        variableName: 'game.state',
        value: LiteralExp('RoundStart'),
      ),
    ],
  ),
);
