import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cards_party/bootstrap.dart';
import 'package:game_repository/game_repository.dart';
import 'package:lobby_repository/lobby_repository.dart';

part 'lobby_screen_state.dart';

class LobbyScreenCubit extends Cubit<LobbyScreenState> {
  LobbyScreenCubit() : super(LobbyScreenInitial());

  final _lobbyRepository = getIt<LobbyRepositoryContract>();
  final _gameRepository = getIt<GameRepositoryContract>();

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
          _lobbyRepository.listenToLobby(lobbyId).listen((lobby) {
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
        final game = Game(id: currentState.lobby.id);
        await _gameRepository.createGame(game);
        await _lobbyRepository.updateLobby(currentState.lobby.id, (lobby) {
          lobby.status = LobbyStatus.started;
          return lobby;
        });
      }
    } on LobbyException catch (e) {
      emit(LobbyScreenError(e.message));
    }
  }

  @override
  Future<void> close() {
    _lobbySubscription.cancel();
    return super.close();
  }
}
