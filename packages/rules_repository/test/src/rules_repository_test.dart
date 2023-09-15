// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:rules_repository/rules_repository.dart';

void main() {
  group('RulesRepository', () {
    test('can be instantiated', () {
      expect(RulesRepository(), isNotNull);
    });
  });
}
