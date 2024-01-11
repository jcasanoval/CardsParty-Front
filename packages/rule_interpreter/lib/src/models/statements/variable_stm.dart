import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template variable_stm}
/// A Statement that returns a variable.
/// {@endtemplate}
class VariableStm<T> extends Statement<T> {
  /// {@macro variable_stm}
  const VariableStm(this.name);

  /// The name of the local variable to return.
  ///
  /// If the variable is nested, the name should be in the format:
  /// `players[0].name`, `currentPlayer.name` or `game.name`
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

    if (parts[0] == 'currentPlayer') {
      final player = game.players.firstWhere((player) => player.id == userId);
      return player.getProperty(parts[1]) as T;
    }

    if (parts[0].contains('players')) {
      final playerIndex = RegExp(r'\[(\d+)\]').firstMatch(parts[0])?.group(1);
      if (playerIndex == null) {
        throw Exception('Invalid variable name: $name');
      }

      final parsedIndex = int.parse(playerIndex);
      if (parsedIndex >= game.players.length || parsedIndex < 0) {
        throw Exception('Player index out of bounds: $parsedIndex');
      }

      final player = game.players[parsedIndex];
      return player.getProperty(parts[1]) as T;
    }

    throw Exception('Invalid variable name: $name');
  }
}
