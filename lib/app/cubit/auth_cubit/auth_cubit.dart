import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';
part 'user.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  User get currentUser => state is Authenticated
      ? (state as Authenticated).user
      : User(id: '', name: 'Unauthenticated');

  void init() {
    Future.delayed(Duration(seconds: 2), () {
      emit(Authenticated(User(id: '1')));
    });
  }
}
