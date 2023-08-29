import 'package:game_repository/game_repository.dart';

/// {@template game_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class FirebaseGameRepository extends GameRepositoryContract {
  /// {@macro game_repository}
  FirebaseGameRepository();

  @override
  Future<Game> createGame(Game game) {
    // TODO: implement createGame
    throw UnimplementedError();
  }

  @override
  Stream<Game> listenToGame(String gameId) {
    // TODO: implement listenToGame
    throw UnimplementedError();
  }

  @override
  Future<void> updateGame(String gameId, Game Function(Game p1) update) {
    // TODO: implement updateGame
    throw UnimplementedError();
  }
}
