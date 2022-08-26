import 'package:auth_repository/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_repository/login_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:password_manager/app/app.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginRepository loginRepository;
  late AuthRepository authRepository;

  setUp(() {
    loginRepository = MockLoginRepository();
    authRepository = MockAuthRepository();
  });

  group('App', () {
    test('returns normally', () {
      expect(
        () => App(
          loginRepository: loginRepository,
          authRepository: authRepository,
        ),
        returnsNormally,
      );
    });
  });
}
