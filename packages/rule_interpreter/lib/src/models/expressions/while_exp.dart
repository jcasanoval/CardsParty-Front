import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template while_exp}
/// An Expression that will evaluate the condition and execute the body while
/// the condition is true.
/// {@endtemplate}
class WhileExp extends Expression {
  /// {@macro while_exp}
  const WhileExp({
    required this.condition,
    required this.body,
  });

  /// The condition of the while loop.
  final Statement<bool> condition;

  /// The body of the while loop.
  final Expression body;

  @override
  void evaluate(Game game, String userId, Context context, [Card? card]) {
    while (condition.evaluate(game, userId, context, card)) {
      if (context.returned) {
        return;
      }

      body.evaluate(game, userId, context, card);
    }
  }
}
