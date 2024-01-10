import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template has_card_stm}
/// A Statement that returns true if the player has the card passed in the
/// evaluate function. If card is null, it will return false.
/// {@endtemplate}
class HasCardStm extends Statement<bool> {
  /// {@macro has_card_stm}
  const HasCardStm();

  @override
  bool evaluate(Game game, String userId, Context context, [Card? card]) {
    if (card == null) return false;

    final player = game.players.firstWhere((player) => player.id == userId);
    return player.cards.contains(card);
  }
}
