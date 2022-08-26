// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:login_repository/login_repository.dart';

void main() {
  group('LoginRepository', () {
    test('can be instantiated', () {
      expect(LoginRepository(), isNotNull);
    });
  });
}
