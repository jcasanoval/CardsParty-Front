import 'package:equatable/equatable.dart';
import 'package:game_repository/game_repository.dart';
import 'package:lobby_repository/lobby_repository.dart';

const _kId = 'id';
const _kPlayers = 'players';
const _kCustomParams = 'customParams';
const _kHostId = 'hostId';
const _kDeck = 'deck';
const _kDiscardPile = 'discardPile';

/// {@template game}
/// A Game.
/// {@endtemplate}
class Game extends Equatable {
  /// {@macro game}
  Game({
    required this.id,
    required this.players,
    required this.hostId,
    required this.deck,
    required this.discardPile,
    this.customParams = const {},
    this.defaultCardVisibility = DefaultCardVisibility.owner,
  });

  /// Creates a [Game] from a json object.
  Game.fromJson(Map<String, dynamic> json)
      : this(
          id: json[_kId] as String,
          players: (json[_kPlayers] as List<Map<String, dynamic>>? ?? [])
              .map(Player.fromJson)
              .toList(),
          customParams: json.containsKey(_kCustomParams)
              ? json[_kCustomParams] as Map<String, dynamic>
              : {},
          hostId: json[_kHostId] as String,
          deck: (json[_kDeck] as List<Map<String, dynamic>>? ?? [])
              .map(Card.fromJson)
              .toList(),
          discardPile:
              (json[_kDiscardPile] as List<Map<String, dynamic>>? ?? [])
                  .map(Card.fromJson)
                  .toList(),
        );

  /// Creates a [Game] from a [Lobby].
  Game.fromLobby(Lobby lobby)
      : this(
          id: lobby.id,
          players: lobby.players.map(Player.fromLobbyPlayer).toList(),
          hostId: lobby.hostId,
          deck: [],
          discardPile: [],
        );

  /// The id of the game.
  final String id;

  /// The list of players in the game.
  final List<Player> players;

  /// The id of the host of the game.
  final String hostId;

  /// The custom parameters of the game.
  final Map<String, dynamic> customParams;

  /// The deck of the game.
  List<Card> deck;

  /// The discard pile of the game.
  List<Card> discardPile;

  /// The default visibility of cards in the game.
  final DefaultCardVisibility defaultCardVisibility;

  /// Returns a json representation of the game.
  Map<String, Object> toJson() {
    return {
      _kId: id,
      _kPlayers: players.map((player) => player.toJson()).toList(),
      _kCustomParams: customParams,
      _kHostId: hostId,
      _kDeck: deck.map((card) => card.toJson()).toList(),
      _kDiscardPile: discardPile.map((card) => card.toJson()).toList(),
    };
  }

  /// Returns the value of the given key. If the key is not found, returns null.
  dynamic getProperty(String key) {
    switch (key) {
      case _kId:
        return id;
      case _kPlayers:
        return players;
      case _kHostId:
        return hostId;
      case _kDeck:
        return deck;
      case _kDiscardPile:
        return discardPile;
      default:
        return customParams[key];
    }
  }

  @override
  List<Object?> get props => [
        id,
        players,
        hostId,
        customParams,
        deck,
        discardPile,
        defaultCardVisibility,
      ];
}
