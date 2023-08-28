import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'find_lobby_state.dart';

class FindLobbyCubit extends Cubit<FindLobbyState> {
  FindLobbyCubit() : super(FindLobbyInitial());
}
