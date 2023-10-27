import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cards_party/bootstrap.dart';
import 'package:equatable/equatable.dart';
import 'package:game_repository/game_repository.dart';
import 'package:meta/meta.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameLoading());

  late final StreamSubscription<Game> _stream;
  late final String _gameId;

  final _gameRepository = getIt<GameRepositoryContract>();

  void listenToGame(String gameId) {
    _gameId = gameId;
    _stream = _gameRepository
        .listenToGame(gameId)
        .listen((game) => emit(GameLoaded(game)));
  }

  @override
  Future<void> close() {
    _stream.cancel();
    return super.close();
  }
}
