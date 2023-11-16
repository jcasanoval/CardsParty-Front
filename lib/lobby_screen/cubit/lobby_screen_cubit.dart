import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:game_repository/game_repository.dart';
import 'package:lobby_repository/lobby_repository.dart';

part 'lobby_screen_state.dart';

class LobbyScreenCubit extends Cubit<LobbyScreenState> {
  LobbyScreenCubit({
    required this.lobbyRepository,
    required this.gameRepository,
  }) : super(LobbyScreenInitial());

  final LobbyRepositoryContract lobbyRepository;
  final GameRepositoryContract gameRepository;

  late final StreamSubscription<Lobby> _lobbySubscription;

  bool isHost(String userId) {
    final currentState = state;
    if (currentState is LobbyLoaded) {
      return currentState.lobby.hostId == userId;
    }
    return false;
  }

  Future<void> loadLobby(String lobbyId) async {
    try {
      _lobbySubscription =
          lobbyRepository.listenToLobby(lobbyId).listen((lobby) {
        if (lobby.status == LobbyStatus.started) {
          emit(GameStarted(lobby));
          return;
        }
        emit(LobbyLoaded(lobby));
      });
    } on LobbyException catch (e) {
      emit(LobbyScreenError(e.message));
    }
  }

  Future<void> startGame() async {
    try {
      final currentState = state;
      if (currentState is LobbyLoaded) {
        final game = Game.fromLobby(currentState.lobby);
        await gameRepository.createGame(game);
        await lobbyRepository.updateLobby(currentState.lobby.id, (lobby) {
          lobby.status = LobbyStatus.started;
          return lobby;
        });
      }
    } on LobbyException catch (e) {
      emit(LobbyScreenError(e.message));
    }
  }

  Future<bool> leaveLobby(String userId) async {
    final currentState = state;
    if (currentState is! LobbyLoaded) {
      return false;
    }
    final lobby = currentState.lobby;
    try {
      await lobbyRepository.updateLobby(lobby.id, (lobby) {
        lobby.players.removeWhere((player) => player.id == userId);
        if (lobby.players.isEmpty) {
          lobby.status = LobbyStatus.canceled;
        } else if (lobby.hostId == userId) {
          lobby.hostId = lobby.players.first.id;
        }
        return lobby;
      });
    } on LobbyException catch (e) {
      emit(LobbyScreenError(e.message));
      return false;
    }
    return true;
  }

  @override
  Future<void> close() {
    _lobbySubscription.cancel();
    return super.close();
  }
}
