part of 'auth_cubit.dart';

class User {
  User({
    required this.id,
    this.name = 'Anonymous',
  });

  final String id;
  final String name;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

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
