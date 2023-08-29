// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:game_repository/game_repository.dart';

void main() {
  group('GameRepository', () {
    test('can be instantiated', () {
      expect(GameRepository(), isNotNull);
    });
  });
}
