import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_repository/src/exceptions.dart';
import 'package:login_repository/src/models/models.dart';
import 'package:rxdart/subjects.dart';

class LoginRepository {
  LoginRepository({
    Box<Login>? loginBox,
    FlutterSecureStorage? passwordStorage,
  })  : _loginBox = loginBox,
        _passwordStorage = passwordStorage ?? const FlutterSecureStorage() {
    _registerAdapters();
  }

  static const _loginBoxName = 'logins';
  Box<Login>? _loginBox;

  final FlutterSecureStorage _passwordStorage;

  final _loginStreamController = BehaviorSubject<List<Login>>.seeded(const []);

  void _registerAdapters() {
    _registerAdapter(LoginAdapter());
  }

  void _registerAdapter<T>(TypeAdapter<T> adapter) {
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(adapter);
    }
  }

  Future<void> initialize() async {
    await Hive.initFlutter();
    _loginBox = await Hive.openBox(_loginBoxName);
    _loginStreamController.add(_loginBox!.values.toList());
  }

  void _checkIsInitialized() {
    if (_loginBox == null) {
      throw LoginRepositoryNotInitializedException();
    }
  }

  Stream<List<Login>> get loginStream {
    return _loginStreamController.asBroadcastStream();
  }

  Future<void> saveLoginData({
    required Login login,
    required String password,
  }) async {
    _checkIsInitialized();
    try {
      final key = await _loginBox!.add(login);
      final logins = _loginStreamController.value;
      _loginStreamController.add([...logins, login]);
      await _passwordStorage.write(key: key.toString(), value: password);
    } on Exception {
      throw LoginDataSaveException();
    }
  }

  Future<String?> getPassword({required Login login}) async {
    try {
      final key = login.key as int;
      return _passwordStorage.read(key: key.toString());
    } on Exception {
      throw PasswordLoadException();
    }
  }
}
