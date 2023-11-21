import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lobby_repository/lobby_repository.dart';
import 'package:meta/meta.dart';

part 'find_lobby_state.dart';

class FindLobbyCubit extends Cubit<FindLobbyState> {
  FindLobbyCubit(this.lobbyRepository) : super(FindLobbyInitial());

  final LobbyRepositoryContract lobbyRepository;

  Future<void> createLobby(LobbyPlayer host) async {
    emit(FindLobbyLoading());
    try {
      final lobby = await lobbyRepository.createLobby(host: host);
      emit(LobbyFound(lobbyId: lobby.id));
    } catch (e) {
      emit(FindLobbyError(error: 'Something went wrong'));
      emit(FindLobbyInitial());
    }
  }

  Future<void> joinByGameCode(String gameCode, LobbyPlayer player) async {
    emit(FindLobbyLoading());
    try {
      final lobby = await lobbyRepository.joinLobbyByGamecode(gameCode, player);
      emit(LobbyFound(lobbyId: lobby.id));
    } on LobbyNotFoundException {
      emit(FindLobbyError(error: 'Lobby not found'));
      emit(FindLobbyInitial());
    } on LobbyFullException {
      emit(FindLobbyError(error: 'Lobby is full'));
      emit(FindLobbyInitial());
    } catch (e) {
      emit(FindLobbyError(error: 'Something went wrong'));
      emit(FindLobbyInitial());
    }
  }
}
