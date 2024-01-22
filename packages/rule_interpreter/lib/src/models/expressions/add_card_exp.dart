import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template add_card_exp}
/// Expression that adds a card to the player's hand.
/// {@endtemplate}
class AddCardExp extends Expression {
  /// {@macro add_card_exp}
  const AddCardExp({
    required this.card,
    this.playerIndex,
  });

  /// The card to add.
  final Statement<Card> card;

  /// The player to add the card to.
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

    chosenPlayer.cards.add(
      this.card.evaluate(
            game,
            userId,
            context,
            card,
          ),
    );
  }
}
