import 'package:game_repository/game_repository.dart';
import 'package:rules_repository/rules_repository.dart';

/// {@template rules_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class MockRulesRepository extends RulesRepositoryContract {
  @override
  Future<GameRuleset> getRules(String rulesetId) async {
    await Future.delayed(const Duration(seconds: 2));
    return mockRuleset;
  }
}

const mockRuleset = GameRuleset(
  id: 'id',
  name: 'name',
  description: 'description',
  rules: [
    MockRule1(),
    MockRule2(),
  ],
);

class MockRule1 extends GameRuleContract {
  const MockRule1();

  @override
  Game applyRule(String userId, Game gameState) {
    final value = gameState.customParams['value'] as int? ?? 0;
    gameState.customParams['value'] = value + 1;
    return gameState;
  }

  @override
  UIElement? conditionMet(String userId, Game gameState) {
    return Button(
      showButton: true,
      buttonLabel:
          'Button pressed ${gameState.customParams['value'] as int? ?? 0} times',
      color: ButtonColor.yellow,
      size: ButtonSize.medium,
      type: ButtonType.rounded,
      enabled: true,
    );
  }
}

class MockRule2 extends GameRuleContract {
  const MockRule2();

  @override
  Game applyRule(String userId, Game gameState) {
    final value = gameState.customParams['hostValue'] as int? ?? 0;
    gameState.customParams['hostValue'] = value + 1;
    return gameState;
  }

  @override
  UIElement? conditionMet(String userId, Game gameState) {
    return Button(
      showButton: true,
      buttonLabel:
          'Button pressed ${gameState.customParams['hostValue'] as int? ?? 0} times by host',
      color: ButtonColor.yellow,
      size: ButtonSize.medium,
      type: ButtonType.rounded,
      enabled: gameState.hostId == userId,
    );
  }
}
