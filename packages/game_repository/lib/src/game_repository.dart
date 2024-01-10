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
            _appSafeData(event.snapshot.value) as Map<String, dynamic>,
          ),
        );
  }

  @override
  Future<void> updateGame(String gameId, Game Function(Game) update) async {
    final tResult = await FirebaseDatabase.instance
        .ref('games/$gameId')
        .runTransaction((gameJson) {
      final game =
          Game.fromJson(_appSafeData(gameJson) as Map<String, dynamic>);
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

  static dynamic _appSafeData(dynamic value) {
    if (value is Map) {
      return value.map<String, dynamic>(
        (key, item) => MapEntry(key as String, _appSafeData(item)),
      );
    }

    if (value is List) {
      if (value.isNotEmpty && value.first is Map) {
        return value
            .map<Map<String, dynamic>>(
              (item) => _appSafeData(item) as Map<String, dynamic>,
            )
            .toList();
      }
      if (value.isNotEmpty && value.first is String) {
        return value
            .map<String>(
              (item) => item as String,
            )
            .toList();
      }
      return value;
    }

    return value;
  }
}
