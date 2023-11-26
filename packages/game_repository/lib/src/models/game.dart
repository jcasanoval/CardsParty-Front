import 'package:equatable/equatable.dart';
import 'package:game_repository/game_repository.dart';
import 'package:lobby_repository/lobby_repository.dart';

const _kId = 'id';
const _kPlayers = 'players';
const _kCustomParams = 'customParams';
const _kHostId = 'hostId';
const _kDeck = 'deck';
const _kDiscardPile = 'discardPile';

class Game extends Equatable {
  Game({
    required this.id,
    required this.players,
    required this.hostId,
    required this.deck,
    required this.discardPile,
    this.customParams = const {},
    // TODO: make this configurable
    this.defaultCardVisibility = DefaultCardVisibility.owner,
  });

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

  Game.fromLobby(Lobby lobby)
      : this(
          id: lobby.id,
          players: lobby.players.map(Player.fromLobbyPlayer).toList(),
          hostId: lobby.hostId,
          deck: [],
          discardPile: [],
        );

  final String id;
  final List<Player> players;
  final String hostId;
  final Map<String, dynamic> customParams;
  List<Card> deck;
  List<Card> discardPile;
  final DefaultCardVisibility defaultCardVisibility;

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

  @override
  List<Object?> get props => [
        id,
        players,
        hostId,
        customParams,
        deck,
        discardPile,
        defaultCardVisibility
      ];
}

enum DefaultCardVisibility {
  owner,
  all,
  none,
}
