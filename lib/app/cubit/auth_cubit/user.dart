part of 'auth_cubit.dart';

class User {
  User({
    required this.id,
    this.name = 'Anonymous',
  });

  final String id;
  final String name;
}
