import 'package:flutter_test/flutter_test.dart';
import 'package:login_repository/login_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:password_manager/app/app.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  late LoginRepository loginRepository;

  setUp(() {
    loginRepository = MockLoginRepository();
  });

  group('App', () {
    test('returns normally', () {
      expect(
        () => App(loginRepository: loginRepository),
        returnsNormally,
      );
    });
  });
}
