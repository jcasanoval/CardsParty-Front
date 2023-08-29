import 'package:lobby_repository/lobby_repository.dart';

/// {@template lobby_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
abstract class LobbyRepositoryContract {
  /// Creates a new lobby.
  Future<Lobby> createLobby();

  /// Joins a lobby with matching [gameCode].
  Future<Lobby> joinLobbyByGamecode(String gameCode);

  /// Listens to a lobby with matching [lobbyId].
  Stream<Lobby> listenToLobby(String lobbyId);

  /// Updates a lobby with matching [lobbyId] using the [update] method provided
  Future<void> updateLobby(String lobbyId, Lobby Function(Lobby) update);
}
