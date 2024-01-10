import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template if_exp}
/// An Expression that evaluates a condition and calls the then or otherwise
/// {@endtemplate}
class IfExp extends Expression {
  /// {@macro if_exp}
  const IfExp({
    required this.condition,
    required this.then,
    this.otherwise,
  });

  /// The condition to evaluate.
  final Statement<bool> condition;

  /// The Expression to evaluate if the condition is true.
  final Expression then;

  /// The Expression to evaluate if the condition is false.
  final Expression? otherwise;

  @override
  void evaluate(Game game, String userId, Context context, [Card? card]) {
    if (context.returned) {
      return;
    }

    if (condition.evaluate(game, userId, context)) {
      then.evaluate(game, userId, context);
    } else {
      otherwise?.evaluate(game, userId, context);
    }
  }
}
