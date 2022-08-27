import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/error_codes.dart' as auth_error_codes;
import 'package:local_auth/local_auth.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalAuthentication extends Mock implements LocalAuthentication {}

class FakeAuthenticationOptions extends Fake implements AuthenticationOptions {}

void main() {
  group('AuthRepository', () {
    late MockLocalAuthentication mockAuth;
    late AuthRepository repository;

    setUpAll(() {
      registerFallbackValue(FakeAuthenticationOptions());
    });

    setUp(() {
      mockAuth = MockLocalAuthentication();
      repository = AuthRepository(auth: mockAuth);
    });

    test('constructor returns normally', () {
      expect(AuthRepository.new, returnsNormally);
    });

    group('.authenticate()', () {
      test('throws AuthenticationLockNotSetException on 3 error codes', () {
        const errorCodes = [
          auth_error_codes.passcodeNotSet,
          auth_error_codes.notEnrolled,
          auth_error_codes.notAvailable,
        ];
        for (final code in errorCodes) {
          when(
            () => mockAuth.authenticate(
              localizedReason: any(named: 'localizedReason'),
              options: any(named: 'options'),
            ),
          ).thenThrow(PlatformException(code: code));
          expect(
            () => repository.authenticate(message: 'message'),
            throwsA(isA<AuthenticationLockNotSetException>()),
          );
        }
      });

      test(
        'throws AuthenticationFailureException on authentication failure',
        () {
          when(
            () => mockAuth.authenticate(
              localizedReason: any(named: 'localizedReason'),
              options: any(named: 'options'),
            ),
          ).thenAnswer((_) async => false);
          expect(
            () => repository.authenticate(message: 'message'),
            throwsA(isA<AuthenticationFailureException>()),
          );

          when(
            () => mockAuth.authenticate(
              localizedReason: any(named: 'localizedReason'),
              options: any(named: 'options'),
            ),
          ).thenThrow(Exception());
          expect(
            () => repository.authenticate(message: 'message'),
            throwsA(isA<AuthenticationFailureException>()),
          );
        },
      );

      test('makes correct request', () {
        when(
          () => mockAuth.authenticate(
            localizedReason: any(named: 'localizedReason'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => true);
        const message = 'message';
        repository.authenticate(message: message);
        verify(
          () => mockAuth.authenticate(
            localizedReason: any(
              named: 'localizedReason',
              that: equals(message),
            ),
            options: any(named: 'options'),
          ),
        ).called(1);
      });

      test('does not use plugin error dialogs', () {
        when(
          () => mockAuth.authenticate(
            localizedReason: any(named: 'localizedReason'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => true);
        repository.authenticate(message: 'message');
        verify(
          () => mockAuth.authenticate(
            localizedReason: any(named: 'localizedReason'),
            options: any(
              named: 'options',
              that: equals(const AuthenticationOptions(useErrorDialogs: false)),
            ),
          ),
        ).called(1);
      });
    });
  });
}
