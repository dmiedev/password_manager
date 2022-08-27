import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:login_repository/login_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockBox extends Mock implements Box<Login> {}

class MockSecureStorage extends Mock implements FlutterSecureStorage {}

class FakeLogin extends Fake implements Login {}

class MockLogin extends Mock implements Login {
  MockLogin({required this.userName, required this.serviceName});

  @override
  final String userName;

  @override
  final String serviceName;
}

void main() {
  final logins = [
    MockLogin(serviceName: 'Service A', userName: 'User A'),
    MockLogin(serviceName: 'Service B', userName: 'Service B'),
  ];

  group('LoginRepository', () {
    late MockBox mockLoginBox;
    late MockSecureStorage mockPasswordStorage;
    late LoginRepository repository;

    setUpAll(() {
      registerFallbackValue(FakeLogin());
    });

    setUp(() {
      mockLoginBox = MockBox();
      when(() => mockLoginBox.values).thenReturn(logins);

      mockPasswordStorage = MockSecureStorage();
      repository = LoginRepository(
        loginBox: mockLoginBox,
        passwordStorage: mockPasswordStorage,
      );
    });

    test('constructor returns normally', () {
      expect(LoginRepository.new, returnsNormally);
    });

    group('initialization', () {
      test('- adapters are registered', () {
        expect(Hive.isAdapterRegistered(LoginAdapter().typeId), true);
      });

      test('is correct with box', () {
        expect(repository.loginStream, emits(logins));
      });

      test('is correct without box', () {
        repository = LoginRepository(passwordStorage: mockPasswordStorage);
        expect(repository.loginStream, emits(const <Login>[]));
      });
    });

    group('.saveLoginData()', () {
      test(
        'throws LoginRepositoryNotInitializedException if the repository is '
        'not initialized',
        () {
          repository = LoginRepository();
          expect(
            () => repository.saveLoginData(
              login: logins.first,
              password: 'password',
            ),
            throwsA(isA<LoginRepositoryNotInitializedException>()),
          );
        },
      );

      test('throws LoginDataSaveException on save failure', () {
        when(() => mockLoginBox.add(any())).thenThrow(Exception());
        expect(
          () => repository.saveLoginData(
            login: logins.first,
            password: 'password',
          ),
          throwsA(isA<LoginDataSaveException>()),
        );
      });

      test('makes correct request', () {
        const key = 1;
        final login = logins.first;
        const password = 'password';
        when(() => mockLoginBox.add(any())).thenAnswer((_) async => key);
        when(
          () => mockPasswordStorage.write(
            key: any(named: 'key', that: equals(key.toString())),
            value: password,
          ),
        ).thenAnswer((_) async {});
        repository.saveLoginData(login: login, password: password);
        expect(
          repository.loginStream,
          emitsInOrder([
            logins,
            [...logins, login],
          ]),
        );
      });
    });

    group('.getPassword()', () {
      const key = 1;
      const password = 'password';

      setUpAll(() {
        when(() => logins.first.key).thenReturn(key);
      });

      test('throws PasswordLoadException on password read failure', () {
        when(
          () => mockPasswordStorage.read(key: any(named: 'key')),
        ).thenThrow(Exception());
        expect(
          () => repository.getPassword(login: logins.first),
          throwsA(isA<PasswordLoadException>()),
        );
      });

      test('makes correct request', () {
        when(
          () => mockPasswordStorage.read(
            key: any(named: 'key', that: equals(key.toString())),
          ),
        ).thenAnswer((_) async => password);
        expect(
          repository.getPassword(login: logins.first),
          completion(equals(password)),
        );
      });
    });
  });
}
