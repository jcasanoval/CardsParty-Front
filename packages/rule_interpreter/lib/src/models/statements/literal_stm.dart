import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template literal_stm}
/// A Statement that returns a literal value.
/// {@endtemplate}
class LiteralStm<T> extends Statement<T> {
  /// {@macro literal_stm}
  const LiteralStm(this.value);

  /// The literal value to return.
  final T value;

  @override
  T evaluate(Game game, String userId, Context context) {
    return value;
  }
}
