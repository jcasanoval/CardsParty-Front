import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template set_variable_exp}
/// An Expression that sets a variable either in the game or the context.
/// {@endtemplate}
class SetVariableExp extends Expression {
  /// {@macro set_variable_exp}
  const SetVariableExp({required this.variableName, required this.value});

  /// The name of the local variable to modify.
  ///
  /// If the variable is located in the game, the name should be in the format:
  /// `game.name`
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
  }
}
