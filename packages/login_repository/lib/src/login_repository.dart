import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_repository/src/exceptions.dart';
import 'package:login_repository/src/models/models.dart';

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
  }

  void _checkIsInitialized() {
    if (_loginBox == null) {
      throw LoginRepositoryNotInitializedException();
    }
  }

  List<Login> get logins {
    _checkIsInitialized();
    return _loginBox!.values.toList();
  }

  Future<void> saveLoginData(Login login, String password) async {
    _checkIsInitialized();
    try {
      final key = await _loginBox!.add(login);
      await _passwordStorage.write(key: key.toString(), value: password);
    } on Exception {
      throw LoginDataSaveException();
    }
  }

  Future<String?> getPassword(Login login) async {
    try {
      final key = login.key as int;
      return _passwordStorage.read(key: key.toString());
    } on Exception {
      throw PasswordLoadException();
    }
  }
}
