import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';
import 'package:rules_repository/rules_repository.dart';

class PassCardRule extends CardRuleContract {
  const PassCardRule() : super(priority: 2);

  @override
  Game applyRule(String userId, Game gameState, Card card) {
    final player =
        gameState.players.firstWhere((player) => player.id == userId);
    player.customParams['chosenCard'] = '${card.number}-${card.suit.key}';

    if (gameState.players
        .every((element) => element.customParams['chosenCard'] != null)) {
      final cards = <Card>[];
      for (final player in gameState.players) {
        final chosenCard = player.customParams['chosenCard'] as String;
        final cardParts = chosenCard.split('-');
        final card = Card(
          number: int.parse(cardParts[0]),
          suit: Suit.fromKey(cardParts[1]),
        );
        cards.add(card);
        player.cards.removeWhere((c) => c == card);
      }

      // Shift cards to the left
      final card = cards[0];
      cards
        ..removeAt(0)
        ..add(card);

      for (final player in gameState.players) {
        player.cards.add(cards[0]);
        player.customParams['chosenCard'] = null;
        cards.removeAt(0);
      }
    }

    return gameState;
  }

  @override
  CardAction? conditionMet(String userId, Game gameState, Card card) {
    final player =
        gameState.players.firstWhere((player) => player.id == userId);
    final chosenCard = player.customParams['chosenCard'] as String?;
    final state = gameState.customParams['state'] as String? ?? 'RoundStart';
    if (player.cards.contains(card) &&
        chosenCard == null &&
        state == 'RoundInProgress') {
      return Drag(enabled: true);
    }
    return Drag(enabled: false);
  }
}

const passCardCustomRule = CustomCardRule(
  priority: 2,
  conditionMetExp: BlockStm(
    expressions: [
      IfStm(
        condition: BoolComparatorExp(
          BoolComparator.equal,
          PlayerVariableExp('chosenCard'),
          LiteralExp(null),
        ),
        then: IfStm(
          condition: BoolComparatorExp(
            BoolComparator.equal,
            VariableExp('game.state'),
            LiteralExp('RoundInProgress'),
          ),
          then: IfStm(
            condition: HasCardExp(),
            then: ReturnDragStm(
              enabled: LiteralExp(true),
              visibility: CardVisibility.visible,
            ),
          ),
        ),
      ),
      ReturnDragStm(
        enabled: LiteralExp(false),
        visibility: CardVisibility.visible,
      ),
    ],
  ),
  applyRuleExp: BlockStm(
    expressions: [
      // Choose card
      SetPlayerVariableStm(
        variableName: 'chosenCard',
        value: CardToStringExp(cardStm: CurrentCardExp()),
      ),
      SetVariableStm(
        variableName: 'iterator',
        value: LiteralExp(0),
      ),
      // Return early if not all players have chosen a card
      WhileStm(
        condition: BoolComparatorExp(
          BoolComparator.lessThan,
          VariableExp('iterator'),
          VariableExp('game.playerCount'),
        ),
        body: IfStm(
          condition: BoolComparatorExp(
            BoolComparator.equal,
            PlayerVariableExp(
              'chosenCard',
              index: VariableExp('iterator'),
            ),
            LiteralExp(null),
          ),
          then: ReturnVoidStm(),
          otherwise: SetVariableStm(
            variableName: 'iterator',
            value: MathExp(
              VariableExp('iterator'),
              MathOperator.add,
              LiteralExp(1),
            ),
          ),
        ),
      ),
      // Reset iterator
      SetVariableStm(
        variableName: 'iterator',
        value: LiteralExp(0),
      ),
      // Shift cards one place
      WhileStm(
        condition: BoolComparatorExp(
          BoolComparator.lessThan,
          VariableExp('iterator'),
          VariableExp('game.playerCount'),
        ),
        body: BlockStm(
          expressions: [
            // Get chosen card
            SetVariableStm(
              variableName: 'chosenCard',
              value: PlayerVariableExp(
                'chosenCard',
                index: VariableExp('iterator'),
              ),
            ),
            SetPlayerVariableStm(
              variableName: 'chosenCard',
              index: VariableExp('iterator'),
              value: LiteralExp(null),
            ),
            // Get next player index
            SetVariableStm(
              variableName: 'nextPlayerIndex',
              value: MathExp(
                VariableExp(
                  'iterator',
                ),
                MathOperator.add,
                LiteralExp(1),
              ),
            ),
            // Check if next player index is greater than player count,
            // then reset to 0
            IfStm(
              condition: BoolComparatorExp(
                BoolComparator.greaterThanOrEqual,
                VariableExp('nextPlayerIndex'),
                VariableExp('game.playerCount'),
              ),
              then: SetVariableStm(
                variableName: 'nextPlayerIndex',
                value: LiteralExp(0),
              ),
            ),
            // Remove chosen card from player
            RemoveCardStm(
              card: StringToCardExp(
                stringStm: VariableExp('chosenCard'),
              ),
              playerIndex: VariableExp('iterator'),
            ),
            // Add chosen card to next player
            AddCardStm(
              card: StringToCardExp(
                stringStm: VariableExp('chosenCard'),
              ),
              playerIndex: VariableExp('nextPlayerIndex'),
            ),
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
    ],
  ),
);
