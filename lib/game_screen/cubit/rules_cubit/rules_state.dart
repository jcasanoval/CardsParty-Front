part of 'rules_cubit.dart';

sealed class RulesState extends Equatable {
  const RulesState();

  @override
  List<Object> get props => [];
}

final class RulesLoading extends RulesState {}

final class RulesLoaded extends RulesState {
  const RulesLoaded(this.ruleset);

  final GameRuleset ruleset;

  @override
  List<Object> get props => [ruleset];
}
