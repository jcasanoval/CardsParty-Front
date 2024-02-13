import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template block_exp}
/// An Expression that evaluates a list of Expressions.
/// {@endtemplate}
class BlockStm extends Statement {
  /// {@macro block_exp}
  const BlockStm({required this.expressions});

  /// The expressions to evaluate.
  final List<Statement> expressions;

  @override
  void evaluate(Game game, String userId, Context context, Card? card) {
    for (final expression in expressions) {
      if (context.returned) {
        return;
      }
      expression.evaluate(game, userId, context, card);
    }
  }
}
