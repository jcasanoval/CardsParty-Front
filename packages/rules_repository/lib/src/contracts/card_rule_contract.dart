import 'package:flutter/widgets.dart';
import 'package:game_repository/game_repository.dart';
import 'package:rules_repository/rules_repository.dart';
import 'package:rules_repository/src/contracts/rule_contract.dart';
import 'package:rules_repository/src/models/card_action.dart';

abstract class CardRuleContract extends RuleContract{
  Game applyRule(String userId, Game gameState, Card card);

  CardAction? conditionMet(String userId, Game gameState, Card card);
}
