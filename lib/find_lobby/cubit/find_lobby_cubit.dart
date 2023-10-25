import 'package:bloc/bloc.dart';
import 'package:cards_party/bootstrap.dart';
import 'package:lobby_repository/lobby_repository.dart';
import 'package:meta/meta.dart';

part 'find_lobby_state.dart';

class FindLobbyCubit extends Cubit<FindLobbyState> {
  FindLobbyCubit() : super(FindLobbyInitial());

  final _lobbyServices = getIt<LobbyRepositoryContract>();

  Future<void> createLobby(LobbyPlayer host) async {
    final initialState = state;
    emit(FindLobbyLoading());
    try {
      final lobby = await _lobbyServices.createLobby(host: host);
      emit(LobbyFound(lobby: lobby));
    } catch (e) {
      emit(FindLobbyError(error: 'Something went wrong'));
      emit(initialState);
    }
  }
}
