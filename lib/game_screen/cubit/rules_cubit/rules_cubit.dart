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
    final uiElements = <UIElement, GameRuleContract>{};
    for (final rule in _ruleset.rules) {
      if (highestPriority == null || highestPriority == rule.priority) {
        final result = rule.conditionMet(userId, gameState);
        if (result != null) {
          uiElements[result] = rule;
          if (result.enabled) {
            highestPriority = rule.priority;
          }
        }
      }
    }
    emit(RulesLoaded(uiElements: uiElements));
  }

  void executeRule(GameRuleContract rule, String userId) {
    gameRepository.updateGame(
      gameId,
      (game) => rule.applyRule(userId, game),
    );
  }
}
