import 'package:game_repository/game_repository.dart';
import 'package:rules_repository/rules_repository.dart';

abstract class GameRuleContract {
  const GameRuleContract();

  final int priority = 0;

  Game applyRule(int userId, Game gameState);

  UIElement? conditionMet(int userId, Game gameState);
}
