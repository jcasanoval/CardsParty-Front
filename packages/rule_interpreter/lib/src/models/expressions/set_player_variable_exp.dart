import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template set_player_variable_exp}
/// An Expression that sets a variable in a player.
///
/// If [index] is not provided, the variable will set returned in the current
/// player.
/// {@endtemplate}
class SetPlayerVariableExp extends Expression {
  /// {@macro set_player_variable_exp}
  const SetPlayerVariableExp({
    required this.variableName,
    required this.value,
    this.index,
  });

  /// The name of the local variable to modify.
  final String variableName;

  /// The value to set the variable to.
  final Statement<dynamic> value;

  /// The index of the player to set the variable in.
  final Statement<int>? index;

  @override
  void evaluate(Game game, String userId, Context context, Card? card) {
    if (context.returned) {
      return;
    }

    late final Player player;

    if (index == null) {
      player = game.players.firstWhere((player) => player.id == userId);
    } else {
      final playerIndex = index!.evaluate(game, userId, context, card);
      player = game.players[playerIndex];
    }

    player.customParams[variableName] =
        value.evaluate(game, userId, context, card);
  }
}
