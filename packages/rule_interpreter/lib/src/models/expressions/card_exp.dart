import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template card_stm}
/// Statement that represents a card.
/// {@endtemplate}
class CardExp extends Expression<Card> {
  /// {@macro card_stm}
  const CardExp({
    required this.number,
    required this.suit,
  });

  /// The number of the card.
  final Expression<int> number;

  /// The suit of the card.
  final Suit suit;

  @override
  Card evaluate(Game game, String userId, Context context, Card? card) {
    return Card(
      number: number.evaluate(game, userId, context, card),
      suit: suit,
    );
  }
}
