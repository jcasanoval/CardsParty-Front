import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template statement}
/// A Statement that can be evaluated.
/// {@endtemplate}
abstract class Statement<T> {
  /// {@macro statement}
  const Statement();

  /// Evaluates the Statement and returns the result.
  T evaluate(Game game, String userId, Context context);
}
