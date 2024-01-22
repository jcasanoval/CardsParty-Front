import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template remove_card_exp}
/// Expression that removes a card from the player's hand.
/// {@endtemplate}
class RemoveCardExp extends Expression {
  /// {@macro remove_card_exp}
  const RemoveCardExp({
    required this.card,
    this.playerIndex,
  });

  /// The card to remove.
  final Statement<Card> card;

  /// The player to remove the card from.
  ///
  /// If null the current player will be used.
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

    chosenPlayer.cards.remove(
      this.card.evaluate(
            game,
            userId,
            context,
            card,
          ),
    );
  }
}
