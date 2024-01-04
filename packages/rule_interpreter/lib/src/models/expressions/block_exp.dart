import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template block_exp}
/// An Expression that evaluates a list of Expressions.
/// {@endtemplate}
class BlockExp extends Expression {
  /// {@macro block_exp}
  const BlockExp({required this.expressions});

  final List<Expression> expressions;

  @override
  void evaluate(Game game, String userId, Context context) {
    for (final expression in expressions) {
      if (context.returned) {
        return;
      }
      expression.evaluate(game, userId, context);
    }
  }
}
