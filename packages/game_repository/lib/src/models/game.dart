const _kId = 'id';
const _kValue = 'value';

class Game {
  Game({
    required this.id,
    this.value = 0,
  });

  Game.fromJson(Map<dynamic, dynamic> json)
      : this(
          id: json[_kId] as String,
          value: (json[_kValue] as int?) ?? 0,
        );

  final String id;
  int value;

  Map<String, dynamic> toJson() {
    return {
      _kId: id,
      _kValue: value,
    };
  }
}
