import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template card_to_string_stm}
/// A Statement that returns the string representation of a card.
/// {@endtemplate}
class CardToStringStm extends Statement<String> {
  /// {@macro card_to_string_stm}
  const CardToStringStm({required this.cardStm});

  final Statement<Card> cardStm;

  @override
  String evaluate(Game game, String userId, Context context, [Card? card]) {
    return cardStm.evaluate(game, userId, context).toString();
  }
}

/// {@template string_to_card_stm}
/// A Statement that returns the card representation of a string.
/// {@endtemplate}
class StringToCardStm extends Statement<Card> {
  /// {@macro string_to_card_stm}
  const StringToCardStm({required this.stringStm});

  final Statement<String> stringStm;

  @override
  Card evaluate(Game game, String userId, Context context, [Card? card]) {
    return Card.fromString(stringStm.evaluate(game, userId, context));
  }
}
