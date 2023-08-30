import 'package:firebase_database/firebase_database.dart';
import 'package:game_repository/game_repository.dart';

/// {@template game_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class FirebaseGameRepository extends GameRepositoryContract {
  /// {@macro game_repository}
  FirebaseGameRepository();

  @override
  Future<void> createGame(Game game) async {
    await FirebaseDatabase.instance.ref('games/${game.id}').set(game.toJson());
  }

  @override
  Stream<Game> listenToGame(String gameId) {
    return FirebaseDatabase.instance.ref('games/$gameId').onValue.map(
          (event) => Game.fromJson(
            event.snapshot.value as Map<dynamic, dynamic>,
          ),
        );
  }

  @override
  Future<void> updateGame(String gameId, Game Function(Game) update) async {
    final tResult = await FirebaseDatabase.instance
        .ref('games/$gameId')
        .runTransaction((gameJson) {
      final game = Game.fromJson(gameJson as Map<dynamic, dynamic>);
      late Transaction transaction;

      try {
        final updatedGame = update(game);
        transaction = Transaction.success(updatedGame.toJson());
      } catch (e) {
        transaction = Transaction.abort();
      }

      return transaction;
    });

    if (!tResult.committed) {
      throw const FailedToUpdateGameException();
    }
  }
}
