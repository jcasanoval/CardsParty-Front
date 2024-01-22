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
  conditionMetExp: BlockExp(
    expressions: [
      IfExp(
        condition: BoolComparatorStm(
          BoolComparator.equal,
          PlayerVariableStm('chosenCard'),
          LiteralStm(null),
        ),
        then: IfExp(
          condition: BoolComparatorStm(
            BoolComparator.equal,
            VariableStm('game.state'),
            LiteralStm('RoundInProgress'),
          ),
          then: IfExp(
            condition: HasCardStm(),
            then: ReturnDragExp(
              enabled: LiteralStm(true),
              visibility: CardVisibility.visible,
            ),
          ),
        ),
      ),
      ReturnDragExp(
        enabled: LiteralStm(false),
        visibility: CardVisibility.visible,
      ),
    ],
  ),
  applyRuleExp: BlockExp(
    expressions: [
      // Choose card
      SetPlayerVariableExp(
        variableName: 'chosenCard',
        value: CardToStringStm(cardStm: CurrentCardStm()),
      ),
      SetVariableExp(
        variableName: 'iterator',
        value: LiteralStm(0),
      ),
      // Return early if not all players have chosen a card
      WhileExp(
        condition: BoolComparatorStm(
          BoolComparator.lessThan,
          VariableStm('iterator'),
          VariableStm('game.playerCount'),
        ),
        body: IfExp(
          condition: BoolComparatorStm(
            BoolComparator.equal,
            PlayerVariableStm(
              'chosenCard',
              index: VariableStm('iterator'),
            ),
            LiteralStm(null),
          ),
          then: ReturnVoidExp(),
          otherwise: SetVariableExp(
            variableName: 'iterator',
            value: MathStm(
              VariableStm('iterator'),
              MathOperator.add,
              LiteralStm(1),
            ),
          ),
        ),
      ),
      // Reset iterator
      SetVariableExp(
        variableName: 'iterator',
        value: LiteralStm(0),
      ),
      // Shift cards one place
      WhileExp(
        condition: BoolComparatorStm(
          BoolComparator.lessThan,
          VariableStm('iterator'),
          VariableStm('game.playerCount'),
        ),
        body: BlockExp(
          expressions: [
            // Get chosen card
            SetVariableExp(
              variableName: 'chosenCard',
              value: PlayerVariableStm(
                'chosenCard',
                index: VariableStm('iterator'),
              ),
            ),
            // Get next player index
            SetVariableExp(
              variableName: 'nextPlayerIndex',
              value: MathStm(
                VariableStm(
                  'iterator',
                ),
                MathOperator.add,
                LiteralStm(1),
              ),
            ),
            // Check if next player index is greater than player count,
            // then reset to 0
            IfExp(
              condition: BoolComparatorStm(
                BoolComparator.greaterThanOrEqual,
                VariableStm('nextPlayerIndex'),
                VariableStm('game.playerCount'),
              ),
              then: SetVariableExp(
                variableName: 'nextPlayerIndex',
                value: LiteralStm(0),
              ),
            ),
            // Remove chosen card from player
            RemoveCardExp(
              card: StringToCardStm(
                stringStm: VariableStm('chosenCard'),
              ),
              playerIndex: VariableStm('iterator'),
            ),
            // Add chosen card to next player
            AddCardExp(
              card: StringToCardStm(
                stringStm: VariableStm('chosenCard'),
              ),
              playerIndex: VariableStm('nextPlayerIndex'),
            ),
          ],
        ),
      ),
    ],
  ),
);
