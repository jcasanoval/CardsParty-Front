import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cards_party/bootstrap.dart';
import 'package:lobby_repository/lobby_repository.dart';

part 'lobby_state.dart';

class LobbyCubit extends Cubit<LobbyState> {
  LobbyCubit() : super(LobbyInitial());

  final _lobbyRepository = getIt<LobbyRepositoryContract>();

  late final StreamSubscription<Lobby> _lobbySubscription;

  Future<void> loadLobby(String lobbyId) async {
    try {
      _lobbySubscription =
          _lobbyRepository.listenToLobby(lobbyId).listen((event) {
        emit(LobbyLoaded(event));
      });
    } on LobbyException catch (e) {
      emit(LobbyError(e.message));
    }
  }

  Future<void> startGame() async {
    try {
      // TODO: Implement start game
      // emit(LobbyLoaded(lobby));
    } on LobbyException catch (e) {
      emit(LobbyError(e.message));
    }
  }

  @override
  Future<void> close() {
    _lobbySubscription.cancel();
    return super.close();
  }
}
