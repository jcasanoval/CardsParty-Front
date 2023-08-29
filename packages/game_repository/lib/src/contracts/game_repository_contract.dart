import 'package:game_repository/game_repository.dart';

abstract class GameRepositoryContract {
  /// Creates a new game.
  Future<Game> createGame(Game game);

  /// Listens to a game with matching [gameId].
  Stream<Game> listenToGame(String gameId);

  /// Updates a game with matching [gameId] using the [update] method provided
  Future<void> updateGame(String gameId, Game Function(Game) update);
}
