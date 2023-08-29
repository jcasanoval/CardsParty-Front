import 'package:lobby_repository/lobby_repository.dart';

/// {@template lobby_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
abstract class LobbyRepositoryContract {
  /// Creates a new lobby.
  Future<Lobby> createLobby();

  /// Joins a lobby with matching [gameCode].
  Future<Lobby> joinLobbyByGamecode(String gameCode);
}
