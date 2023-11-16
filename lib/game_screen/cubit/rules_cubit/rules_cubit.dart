import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rules_repository/rules_repository.dart';

part 'rules_state.dart';

class RulesCubit extends Cubit<RulesState> {
  RulesCubit() : super(RulesLoading());

  void init(String rulesetId) {
    // emit(RulesLoading());
  }
}
