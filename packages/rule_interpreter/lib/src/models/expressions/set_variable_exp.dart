import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template set_variable_exp}
/// An Expression that sets a variable.
/// {@endtemplate}
class SetVariableExp extends Expression {
  /// {@macro set_variable_exp}
  const SetVariableExp({required this.variableName, required this.value});

  /// The name of the local variable to modify.
  ///
  /// If the variable is nested, the name should be in the format:
  /// `players[0].name`, `currentPlayer.name` or `game.name`
  ///
  /// Otherwise, it will be assumed that the variable is in the context.
  final String variableName;

  /// The value to set the variable to.
  final Statement<dynamic> value;

  @override
  void evaluate(Game game, String userId, Context context, Card? card) {
    if (context.returned) {
      return;
    }

    if (!variableName.contains('.')) {
      context.setVariable(
        variableName,
        value.evaluate(game, userId, context, card),
      );
    }

    final parts = variableName.split('.');
    if (parts[0] == 'game') {
      game.customParams[parts[1]] = value.evaluate(game, userId, context, card);
    }

    if (parts[0] == 'currentPlayer') {
      final player = game.players.firstWhere((player) => player.id == userId);
      player.customParams[parts[1]] =
          value.evaluate(game, userId, context, card);
    }

    if (parts[0].contains('players')) {
      final playerIndex = RegExp(r'\[(\d+)\]').firstMatch(parts[0])?.group(1);
      if (playerIndex == null) {
        throw Exception('Invalid variable variableName: $variableName');
      }

      final parsedIndex = int.parse(playerIndex);
      if (parsedIndex >= game.players.length || parsedIndex < 0) {
        throw Exception('Player index out of bounds: $parsedIndex');
      }

      final player = game.players[parsedIndex];
      player.customParams[parts[1]] =
          value.evaluate(game, userId, context, card);
    }
  }
}
