part of 'auth_cubit.dart';

class User {
  User({
    required this.id,
    this.name = 'Anonymous',
  });

  final String id;
  final String name;

  User copyWith({
    String? id,
    String? name,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
