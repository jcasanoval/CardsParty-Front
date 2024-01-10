import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template deal_each_exp}
/// An Expression that deals each player a set number of cards.
/// {@endtemplate}
class DealEachExp extends Expression {
  /// {@macro deal_each_exp}
  const DealEachExp({required this.amount});

  /// The number of cards to deal each player.
  final Statement<int> amount;

  @override
  void evaluate(Game game, String userId, Context context, [Card? card]) {
    final amount = this.amount.evaluate(game, userId, context);
    for (final player in game.players) {
      for (var i = 0; i < amount; i++) {
        player.cards.add(game.deck.removeAt(0));
      }
    }
  }
}
