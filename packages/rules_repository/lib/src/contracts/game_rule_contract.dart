import 'package:game_repository/game_repository.dart';
import 'package:rules_repository/rules_repository.dart';
import 'package:rules_repository/src/contracts/rule_contract.dart';

abstract class GameRuleContract extends RuleContract {
  const GameRuleContract();
  
  Game applyRule(String userId, Game gameState);

  UIElement? conditionMet(String userId, Game gameState);
}
