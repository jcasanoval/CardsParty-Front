import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';

/// {@template discard_exp}
/// Expression that discards a card from the player's hand.
/// {@endtemplate}
class DiscardStm extends Statement {
  /// {@macro discard_exp}
  const DiscardStm({
    required this.discard,
    this.playerIndex,
    this.deck = const LiteralExp(false),
  });

  /// The card to discard.
  final Expression<Card> discard;

  /// The player to discard the card from.
  final Expression<int>? playerIndex;

  /// If true, the card will be discarded to de deck rather than to the discard
  /// pile.
  final Expression<bool> deck;

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

    final discardedCard = discard.evaluate(
      game,
      userId,
      context,
      card,
    );

    chosenPlayer.cards.remove(discardedCard);

    if (deck.evaluate(game, userId, context, card)) {
      game.deck.add(discardedCard);
    } else {
      game.discardPile.add(discardedCard);
    }
  }
}
