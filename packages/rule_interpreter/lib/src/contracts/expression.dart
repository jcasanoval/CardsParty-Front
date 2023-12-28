import 'package:game_repository/game_repository.dart';

/// An Expression that can be evaluated.
abstract class Expression {
  /// Evaluates the Expression and modifies the provided game and context.
  void evaluate(Game game, Map<String, dynamic> context);
}
