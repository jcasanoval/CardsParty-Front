part of 'rules_cubit.dart';

sealed class RulesState extends Equatable {
  const RulesState();

  @override
  List<Object> get props => [];
}

final class RulesInitial extends RulesState {}

final class RulesLoading extends RulesState {}

final class RulesLoaded extends RulesState {
  const RulesLoaded({
    this.uiElements = const [],
    this.cardRules = const [],
  });

  final List<GameRuleWrapper> uiElements;

  final List<CardRuleWrapper> cardRules;

  @override
  List<Object> get props => [uiElements, cardRules];
}

final class RulesError extends RulesState {
  const RulesError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
