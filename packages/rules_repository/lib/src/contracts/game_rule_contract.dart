import 'package:game_repository/game_repository.dart';
import 'package:rules_repository/rules_repository.dart';

abstract class GameRuleContract {
  const GameRuleContract({this.priority = 0});

  final int priority;

  Game applyRule(String userId, Game gameState);

  UIElement? conditionMet(String userId, Game gameState);
}
