import 'package:rules_repository/rules_repository.dart';

class GameRuleset {
  const GameRuleset({
    required this.id,
    this.name = '',
    this.description = '',
    this.rules = const [],
  });

  final String id;

  final String name;

  final String description;

  final List<GameRuleContract> rules;
}
