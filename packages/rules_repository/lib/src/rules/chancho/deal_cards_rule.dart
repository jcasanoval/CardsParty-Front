import 'package:game_repository/game_repository.dart';
import 'package:rules_repository/rules_repository.dart';

class DealCardsRule extends GameRuleContract {
  const DealCardsRule() : super(priority: 0);

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
    }

    cards.shuffle();

    for (final player in gameState.players) {
      player.cards.addAll(cards.sublist(0, 4));
      cards.removeRange(0, 4);
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
