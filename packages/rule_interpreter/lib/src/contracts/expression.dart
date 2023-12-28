import 'package:game_repository/game_repository.dart';

/// {@template expression}
/// An Expression that can be evaluated.
/// {@endtemplate}
abstract class Expression {
  /// {@macro expression}
  const Expression();

  /// Evaluates the Expression and modifies the provided game and context.
  void evaluate(Game game, String userId, Map<String, dynamic> context);
}
