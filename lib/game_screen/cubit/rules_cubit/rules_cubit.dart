import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:game_repository/game_repository.dart';
import 'package:rules_repository/rules_repository.dart';

part 'rules_state.dart';

class RulesCubit extends Cubit<RulesState> {
  RulesCubit({
    required this.rulesRepository,
    required this.gameRepository,
    required this.gameId,
  }) : super(RulesInitial());

  final RulesRepositoryContract rulesRepository;
  final GameRepositoryContract gameRepository;

  final String gameId;
  late GameRuleset _ruleset;

  Future<void> init(String rulesetId) async {
    emit(RulesLoading());
    _ruleset = await rulesRepository.getRules(rulesetId);
    emit(const RulesLoaded());
  }

  void updateGameState(Game gameState, String userId) {
    int? highestPriority;
    final uiElements = <GameRuleWrapper>[];
    final cardActions = <CardRuleWrapper>[];
    for (final rule in _ruleset.rules) {
      var updateHighestPriority = false;
      if (highestPriority == null || highestPriority == rule.priority) {
        if (rule is GameRuleContract) {
          updateHighestPriority =
              _processGameRule(rule, userId, gameState, uiElements);
        } else if (rule is CardRuleContract) {
          updateHighestPriority = _processCardRule(
            rule,
            userId,
            gameState,
            cardActions,
          );
        }
      }
      if (updateHighestPriority) {
        highestPriority = rule.priority;
      }
    }
    emit(RulesLoaded(uiElements: uiElements, cardRules: cardActions));
  }

  /// Returns true if the rule was enabled and added to the list of UIElements
  bool _processGameRule(
    GameRuleContract rule,
    String userId,
    Game game,
    List<GameRuleWrapper> uiElements,
  ) {
    final result = rule.conditionMet(userId, game);
    if (result != null) {
      switch (result) {
        case Button():
          uiElements.add(GameRuleWrapper<Button>(rule, result));
      }
      return result.enabled;
    }
    return false;
  }

  /// Returns true if the rule was enabled and added to the list of CardAction
  bool _processCardRule(
    CardRuleContract rule,
    String userId,
    Game game,
    List<CardRuleWrapper> cardActions,
  ) {
    var enabled = false;
    for (final player in game.players) {
      for (final card in player.cards) {
        final result = rule.conditionMet(userId, game, card);
        if (result == null || cardActions.any((e) => e.card == card)) {
          continue;
        }
        switch (result) {
          case Drag():
            cardActions.add(CardRuleWrapper<Drag>(rule, result, card));
        }
        enabled = result.enabled || enabled;
      }
    }
    return enabled;
  }

  Future<void> executeRule(
    RuleContract rule,
    String userId, [
    Card? card,
  ]) async {
    try {
      await gameRepository.updateGame(gameId, (game) {
        if (rule is CardRuleContract) {
          final result = rule.conditionMet(userId, game, card!);
          if (result != null && result.enabled) {
            rule.applyRule(userId, game, card);
          }
        } else if (rule is GameRuleContract) {
          final result = rule.conditionMet(userId, game);
          if (result != null && result.enabled) {
            rule.applyRule(userId, game);
          }
        } else {
          throw Exception('Rule not found');
        }
        return game;
      });
    } catch (e) {
      final currentState = state;
      emit(const RulesError('Oops, something went wrong!'));
      emit(currentState);
    }
  }
}

class GameRuleWrapper<T extends UIElement> {
  GameRuleWrapper(this.rule, this.result);

  final GameRuleContract rule;
  final T result;
}

class CardRuleWrapper<T extends CardAction> {
  CardRuleWrapper(this.rule, this.result, this.card);

  final CardRuleContract rule;
  final T result;
  final Card card;
}
