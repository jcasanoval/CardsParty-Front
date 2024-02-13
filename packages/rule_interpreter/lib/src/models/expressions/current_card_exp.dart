import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template current_card_stm}
/// A Statement that returns the current card.
/// {@endtemplate}
class CurrentCardExp extends Expression<Card> {
  /// {@macro current_card_stm}
  const CurrentCardExp();

  @override
  Card evaluate(Game game, String userId, Context context, Card? card) {
    if (card == null) {
      throw Exception('Card is null');
    }

    return card;
  }
}
