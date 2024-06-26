part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class Authenticated extends AuthState {
  Authenticated(this.user);

  final User user;
}
