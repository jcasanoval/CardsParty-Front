const _kId = 'id';

class Game {
  Game({
    required this.id,
  });

  Game.fromJson(Map<String, dynamic> json) : this(id: json[_kId] as String);

  final String id;

  Map<String, dynamic> toJson() {
    return {
      _kId: id,
    };
  }
}
