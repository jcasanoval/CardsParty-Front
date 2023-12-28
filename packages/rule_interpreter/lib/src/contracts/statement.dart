import 'package:game_repository/game_repository.dart';

/// A Statement that can be evaluated.
abstract class Statement<T> {
  /// Evaluates the Statement and returns the result.
  T evaluate(Game game, Map<String, dynamic> context);
}
