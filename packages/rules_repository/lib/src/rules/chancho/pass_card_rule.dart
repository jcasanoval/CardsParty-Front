import 'package:game_repository/game_repository.dart';
import 'package:rules_repository/rules_repository.dart';

class PassCardRule extends CardRuleContract {
  const PassCardRule() : super(priority: 1);

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
