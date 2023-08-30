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
  Future<void> updateGame(String gameId, Game Function(Game p1) update) {
    // TODO: implement updateGame
    throw UnimplementedError();
  }
}
