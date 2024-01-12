import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template player_variable_stm}
/// A Statement that returns a variable located in a player.
///
/// If [index] is not provided, the variable will be returned from the current
/// player.
/// {@endtemplate}
class PlayerVariableStm<T> extends Statement<T> {
  /// {@macro player_variable_stm}
  const PlayerVariableStm(this.name, {this.index});

  /// The name of the local variable to return.
  final String name;

  /// The index of the player to return the variable from.
  final Statement<int>? index;

  @override
  T evaluate(Game game, String userId, Context context, Card? card) {
    late final Player player;

    if (index == null) {
      player = game.players.firstWhere((player) => player.id == userId);
    } else {
      final playerIndex = index!.evaluate(game, userId, context, card);
      player = game.players[playerIndex];
    }

    return player.getProperty(name) as T;
  }
}
