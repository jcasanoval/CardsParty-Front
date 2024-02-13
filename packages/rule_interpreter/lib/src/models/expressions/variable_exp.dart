import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template variable_stm}
/// A Statement that returns a variable located in the game or context.
/// {@endtemplate}
class VariableExp<T> extends Expression<T> {
  /// {@macro variable_stm}
  const VariableExp(this.name);

  /// The name of the local variable to return.
  ///
  /// If the variable is located in the game, the name should be in the format:
  /// `game.name`
  ///
  /// Otherwise, it will be assumed that the variable is in the context.
  ///
  /// If the variable has not been set, an exception will be thrown.
  final String name;

  @override
  T evaluate(Game game, String userId, Context context, Card? card) {
    if (!name.contains('.')) {
      return context.getVariable<T>(name);
    }

    final parts = name.split('.');
    if (parts[0] == 'game') {
      return game.getProperty(parts[1]) as T;
    }

    throw Exception('Invalid variable name: $name');
  }
}
