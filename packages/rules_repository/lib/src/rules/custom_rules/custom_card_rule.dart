import 'package:game_repository/src/models/card.dart';
import 'package:game_repository/src/models/game.dart';
import 'package:rule_interpreter/rule_interpreter.dart';
import 'package:rules_repository/rules_repository.dart';

class CustomCardRule extends CardRuleContract {
  const CustomCardRule({
    required this.applyRuleExp,
    required this.conditionMetExp,
    required super.priority,
  });

  final Expression applyRuleExp;

  final Expression conditionMetExp;

  @override
  Game applyRule(String userId, Game gameState, Card card) {
    final context = Context();
    applyRuleExp.evaluate(gameState, userId, context);
    return gameState;
  }

  @override
  CardAction? conditionMet(String userId, Game gameState, Card card) {
    final context = Context();
    conditionMetExp.evaluate(gameState, userId, context);
    return context.returnValue as CardAction?;
  }
}
