import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';
import 'package:rule_interpreter/src/models/expressions/expressions.dart';

/// {@template has_card_stm}
/// A Statement that returns true if the player has the card passed in the
/// evaluate function. If card is null, it will return false.
/// {@endtemplate}
class HasCardExp extends Expression<bool> {
  /// {@macro has_card_stm}
  const HasCardExp({
    this.cardStm = const CurrentCardExp(),
  });

  /// The card to check if the player has.
  final Expression<Card> cardStm;

  @override
  bool evaluate(Game game, String userId, Context context, Card? card) {
    final player = game.players.firstWhere((player) => player.id == userId);
    return player.cards.contains(cardStm.evaluate(game, userId, context, card));
  }
}
