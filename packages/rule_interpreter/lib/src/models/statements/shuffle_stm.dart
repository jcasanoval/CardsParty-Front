import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template shuffle_exp}
/// Expression that shuffles the deck.
/// {@endtemplate}
class ShuffleStm extends Statement {
  /// {@macro shuffle_exp}
  const ShuffleStm();

  @override
  void evaluate(Game game, String userId, Context context, Card? card) {
    if (context.returned) {
      return;
    }

    game.deck.shuffle();
  }
}
