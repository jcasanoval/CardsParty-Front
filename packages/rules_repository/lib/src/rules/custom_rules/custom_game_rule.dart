import 'package:game_repository/game_repository.dart';
import 'package:rule_interpreter/rule_interpreter.dart';
import 'package:rules_repository/rules_repository.dart';

class CustomGameRule extends GameRuleContract {
  const CustomGameRule({
    required this.applyRuleExp,
    required this.conditionMetExp,
    required super.priority,
  });

  final Statement applyRuleExp;

  final Statement conditionMetExp;

  @override
  Game applyRule(String userId, Game gameState) {
    final context = Context();
    applyRuleExp.evaluate(gameState, userId, context, null);
    return gameState;
  }

  @override
  UIElement? conditionMet(String userId, Game gameState) {
    final context = Context();
    conditionMetExp.evaluate(gameState, userId, context, null);
    return context.returnValue as UIElement?;
  }
}
