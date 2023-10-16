import 'package:game_repository/game_repository.dart';
import 'package:rules_repository/rules_repository.dart';

abstract class GameRuleContract {
  final int priority = 0;
  final bool enabled = false;

  Game applyRule(int userId, Game gameState);

  UIElement? conditionMet(int userId, Game gameState);
}
