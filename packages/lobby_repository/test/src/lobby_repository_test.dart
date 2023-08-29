// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:lobby_repository/lobby_repository.dart';

void main() {
  group('LobbyRepository', () {
    test('can be instantiated', () {
      expect(FirebaseLobbyRepository(), isNotNull);
    });
  });
}
