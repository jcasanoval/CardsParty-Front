import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template set_score_exp}
/// Expression that sets the score of a player.
/// {@endtemplate}
class SetScoreExp extends Expression {
  /// {@macro set_score_exp}
  const SetScoreExp({required this.value, this.playerIndex});

  /// The value to set the score to.
  final Statement<int> value;

  /// The player to set the score to. If null, the score will be set to the
  /// current player.
  final Statement<int>? playerIndex;

  @override
  void evaluate(Game game, String userId, Context context, Card? card) {
    if (context.returned) {
      return;
    }

    late final Player chosenPlayer;

    if (playerIndex != null) {
      chosenPlayer =
          game.players[playerIndex!.evaluate(game, userId, context, card)];
    } else {
      chosenPlayer = game.players.firstWhere((player) => player.id == userId);
    }

    chosenPlayer.score = value.evaluate(game, userId, context, card);
  }
}
