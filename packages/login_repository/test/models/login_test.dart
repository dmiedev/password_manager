// ignore_for_file: prefer_const_constructors

import 'package:login_repository/login_repository.dart';
import 'package:test/test.dart';

void main() {
  group('Login', () {
    final info = Login(serviceName: 'Service', userName: 'User');

    test('supports value comparisons', () {
      expect(info, Login(serviceName: 'Service', userName: 'User'));
    });
  });
}
