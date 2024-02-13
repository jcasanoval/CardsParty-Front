import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template expression}
/// An Expression that can be evaluated.
/// {@endtemplate}
abstract class Statement {
  /// {@macro expression}
  const Statement();

  /// Evaluates the Expression and modifies the provided game and context.
  void evaluate(Game game, String userId, Context context, Card? card);
}
