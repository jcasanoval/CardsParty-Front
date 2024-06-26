import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template literal_stm}
/// A Statement that returns a literal value.
/// {@endtemplate}
class LiteralExp<T> extends Expression<T> {
  /// {@macro literal_stm}
  const LiteralExp(this.value);

  /// The literal value to return.
  final T value;

  @override
  T evaluate(Game game, String userId, Context context, Card? card) {
    return value;
  }
}
