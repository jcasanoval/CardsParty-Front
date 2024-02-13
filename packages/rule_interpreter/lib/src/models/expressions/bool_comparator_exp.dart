import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template bool_comparator_stm}
/// A Statement that returns a boolean based on the comparator.
/// {@endtemplate}
class BoolComparatorExp extends Expression<bool> {
  /// {@macro bool_comparator_stm}
  const BoolComparatorExp(this.comparator, this.left, this.right);

  /// The comparator to use.
  final BoolComparator comparator;

  /// The left side of the comparator.
  final Expression<dynamic> left;

  /// The right side of the comparator.
  final Expression<dynamic> right;

  @override
  bool evaluate(Game game, String userId, Context context, Card? card) {
    final leftValue = left.evaluate(game, userId, context, card);
    final rightValue = right.evaluate(game, userId, context, card);

    switch (comparator) {
      case BoolComparator.equal:
        return leftValue == rightValue;
      case BoolComparator.notEqual:
        return leftValue != rightValue;
      case BoolComparator.greaterThan:
        if (leftValue is! num || rightValue is! num) {
          throw Exception('Cannot compare non-numbers');
        }
        return leftValue > rightValue;
      case BoolComparator.greaterThanOrEqual:
        if (leftValue is! num || rightValue is! num) {
          throw Exception('Cannot compare non-numbers');
        }
        return leftValue >= rightValue;
      case BoolComparator.lessThan:
        if (leftValue is! num || rightValue is! num) {
          throw Exception('Cannot compare non-numbers');
        }
        return leftValue < rightValue;
      case BoolComparator.lessThanOrEqual:
        if (leftValue is! num || rightValue is! num) {
          throw Exception('Cannot compare non-numbers');
        }
        return leftValue <= rightValue;
    }
  }
}

/// Represents a boolean comparator.
enum BoolComparator {
  /// Returns true if both statements are true.
  equal,

  /// Returns true if both statements are not equal.
  notEqual,

  /// Returns true if the first element is greater than the second.
  greaterThan,

  /// Returns true if the first element is greater than or equal to the second.
  greaterThanOrEqual,

  /// Returns true if the first element is less than the second.
  lessThan,

  /// Returns true if the first element is less than or equal to the second.
  lessThanOrEqual,
}
