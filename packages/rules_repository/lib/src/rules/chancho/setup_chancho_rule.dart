import 'package:game_repository/game_repository.dart';
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
