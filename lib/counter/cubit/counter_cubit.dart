import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cards_party/bootstrap.dart';
import 'package:game_repository/game_repository.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  late final StreamSubscription<Game> _stream;
  late final String _gameId;

  final _gameRepository = getIt<GameRepositoryContract>();

  void listenToGame(String gameId) {
    _gameId = gameId;
    _stream = _gameRepository.listenToGame(gameId).listen(
          (game) => emit(game.customParams['value'] as int? ?? 0),
        );
  }

  void increment() {
    _gameRepository.updateGame(_gameId, (game) {
      final value = game.customParams['value'] as int? ?? 0;
      game.customParams['value'] = value + 1;
      return game;
    });
  }

  void decrement() {
    _gameRepository.updateGame(_gameId, (game) {
      final value = game.customParams['value'] as int? ?? 0;
      game.customParams['value'] = value - 1;
      return game;
    });
  }

  @override
  Future<void> close() {
    _stream.cancel();
    return super.close();
  }
}
