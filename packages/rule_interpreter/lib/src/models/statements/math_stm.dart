import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template math_stm}
/// A Statement that performs a mathematical operation on two Statements.
/// {@endtemplate}
class MathStm extends Statement<num> {
  /// {@macro math_stm}
  const MathStm(
    this.left,
    this.operator,
    this.right,
  );

  /// The left side of the operation.
  final Statement<num> left;

  /// The right side of the operation.
  final Statement<num> right;

  /// The operator to use.
  final MathOperator operator;

  @override
  num evaluate(Game game, String userId, Context context, Card? card) {
    final leftValue = left.evaluate(game, userId, context, card);
    final rightValue = right.evaluate(game, userId, context, card);

    switch (operator) {
      case MathOperator.add:
        return leftValue + rightValue;
      case MathOperator.subtract:
        return leftValue - rightValue;
      case MathOperator.multiply:
        return leftValue * rightValue;
      case MathOperator.divide:
        return leftValue / rightValue;
      case MathOperator.module:
        return leftValue % rightValue;
    }
  }
}

/// Represents a mathematical operator.
enum MathOperator {
  /// Adds two numbers.
  add,

  /// Subtracts two numbers.
  subtract,

  /// Multiplies two numbers.
  multiply,

  /// Divides two numbers.
  divide,

  /// Returns the remainder of two numbers.
  module,
}
