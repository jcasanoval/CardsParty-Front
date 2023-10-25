import 'package:flutter_guid/flutter_guid.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';
part 'user.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  User get currentUser => state is Authenticated
      ? (state as Authenticated).user
      : User(id: '', name: 'Unauthenticated');

  void init() {
    if (state is AuthInitial) {
      final guid = Guid.generate();
      emit(Authenticated(User(id: guid.value)));
    }
  }

  void changeName(String name) {
    if (state is Authenticated) {
      emit(Authenticated((state as Authenticated).user.copyWith(name: name)));
    }
  }

  @override
  AuthState fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      return Authenticated(User.fromJson(json['user'] as Map<String, dynamic>));
    }
    final guid = Guid.generate();
    return Authenticated(User(id: guid.value));
  }

  @override
  Map<String, dynamic> toJson(AuthState state) {
    if (state is Authenticated) {
      return {'user': state.user.toJson()};
    }
    return {};
  }
}
