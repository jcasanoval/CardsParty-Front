import 'dart:math';

const _kId = 'id';
const _kGameCode = 'gameCode';

class Lobby {
  const Lobby({
    required this.gameCode,
    this.id = '',
  });

  final String id;
  final String gameCode;

  Lobby.withRandomCode({
    required String id,
  }) : this(
          id: id,
          gameCode: _generateRandomCode(),
        );

  static String _generateRandomCode() {
    final random = Random();
    final asciiA = 'A'.codeUnitAt(0);
    final asciiZ = 'Z'.codeUnitAt(0);
    final codeUnits = List.generate(4, (index) {
      return random.nextInt(asciiZ - asciiA + 1) + asciiA;
    });

    return String.fromCharCodes(codeUnits);
  }

  Lobby.fromJson(Map<String, Object?> json)
      : this(
          id: json[_kId]! as String,
          gameCode: json[_kGameCode]! as String,
        );

  Map<String, Object?> toJson() {
    return {
      _kId: id,
      _kGameCode: gameCode,
    };
  }
}
