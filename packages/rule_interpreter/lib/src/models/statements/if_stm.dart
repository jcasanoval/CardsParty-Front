import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template if_exp}
/// An Expression that evaluates a condition and calls the then or otherwise
/// {@endtemplate}
class IfStm extends Statement {
  /// {@macro if_exp}
  const IfStm({
    required this.condition,
    required this.then,
    this.otherwise,
  });

  /// The condition to evaluate.
  final Expression<bool> condition;

  /// The Expression to evaluate if the condition is true.
  final Statement then;

  /// The Expression to evaluate if the condition is false.
  final Statement? otherwise;

  @override
  void evaluate(Game game, String userId, Context context, Card? card) {
    if (context.returned) {
      return;
    }

    if (condition.evaluate(game, userId, context, card)) {
      then.evaluate(game, userId, context, card);
    } else {
      otherwise?.evaluate(game, userId, context, card);
    }
  }
}
