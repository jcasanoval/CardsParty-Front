import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template return_void_exp}
/// An Expression that will return from the current function.
///
/// This is used to avoid executing the rest of the function.
/// {@endtemplate}
class ReturnVoidExp extends Expression {
  /// {@macro return_void_exp}
  const ReturnVoidExp();

  @override
  void evaluate(Game game, String userId, Context context, Card? card) {
    context.returned = true;
  }
}
