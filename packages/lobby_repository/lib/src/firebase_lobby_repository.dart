import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lobby_repository/lobby_repository.dart';

/// Provides an instance of the lobbies collection
CollectionReference<Lobby> _usersCollectionInstance() {
  return FirebaseFirestore.instance.collection('users').withConverter<Lobby>(
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
  Future<Lobby> createLobby() {
    // TODO: implement createLobby
    throw UnimplementedError();
  }

  @override
  Future<Lobby> joinLobby(String gameCode) {
    // TODO: implement joinLobby
    throw UnimplementedError();
  }
}
