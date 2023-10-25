import 'package:cards_party/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension CurrentUser on BuildContext {
  User get currentUser => read<AuthCubit>().currentUser;
}
