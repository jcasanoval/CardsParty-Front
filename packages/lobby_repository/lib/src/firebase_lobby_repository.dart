import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lobby_repository/lobby_repository.dart';

/// Provides an instance of the lobbies collection
CollectionReference<Lobby> _usersCollectionInstance() {
  return FirebaseFirestore.instance.collection('lobbies').withConverter<Lobby>(
        fromFirestore: (snapshot, _) => Lobby.fromJson(snapshot.data()!),
        toFirestore: (lobby, _) => lobby.toJson(),
      );
}

/// {@template lobby_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class FirebaseLobbyRepository extends LobbyRepositoryContract {
  /// {@macro lobby_repository}
  FirebaseLobbyRepository({
    CollectionReference<Lobby>? lobbyCollection,
  }) : _lobbyCollection = lobbyCollection ?? _usersCollectionInstance();

  final CollectionReference<Lobby> _lobbyCollection;

  @override
  Future<Lobby> createLobby({
    required LobbyPlayer host,
  }) async {
    final doc = _lobbyCollection.doc();
    final lobby = Lobby.withRandomCode(
      id: doc.id,
      created: DateTime.now(),
      hostId: host.id,
    );
    lobby.players.add(host);
    await doc.set(lobby);
    return lobby;
  }

  @override
  Future<Lobby> joinLobbyByGamecode(String gameCode, LobbyPlayer player) async {
    final snapshot = await _lobbyCollection
        .where('gameCode', isEqualTo: gameCode)
        .where('status', isEqualTo: LobbyStatus.waiting.key)
        .orderBy('created', descending: true)
        .get();
    if (snapshot.docs.isEmpty) {
      throw const LobbyNotFoundException();
    }
    var lobbyFound = snapshot.docs.first.data();
    if (lobbyFound.players.any((p) => p.id == player.id)) {
      return lobbyFound;
    }
    await updateLobby(lobbyFound.id, (lobby) {
      lobby.players.add(player);
      lobbyFound = lobby;
      return lobby;
    });
    return lobbyFound;
  }

  @override
  Stream<Lobby> listenToLobby(String lobbyId) {
    return _lobbyCollection.doc(lobbyId).snapshots().map((snapshot) {
      if (!snapshot.exists) {
        throw const LobbyNotFoundException();
      }
      return snapshot.data()!;
    });
  }

  @override
  Future<void> updateLobby(String lobbyId, Lobby Function(Lobby) update) async {
    final lobbyRef = _lobbyCollection.doc(lobbyId);
    await FirebaseFirestore.instance.runTransaction<void>((transaction) async {
      final snapshot = await transaction.get(lobbyRef);
      if (!snapshot.exists) {
        throw const LobbyNotFoundException();
      }
      final lobby = snapshot.data()!;

      final updatedLobby = update(lobby);

      transaction.update(lobbyRef, updatedLobby.toJson());
    });
  }
}
