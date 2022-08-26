import 'package:hive/hive.dart';
import 'package:login_repository/src/models/models.dart';

class LoginRepository {
  LoginRepository({Box<Login>? box}) : _box = box {
    _registerAdapters();
  }

  static const _boxName = 'logins';
  Box<Login>? _box;

  void _registerAdapters() {
    _registerAdapter(LoginAdapter());
  }

  void _registerAdapter<T>(TypeAdapter<T> adapter) {
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(adapter);
    }
  }

  Future<void> initialize() async {
    _box = await Hive.openBox(_boxName);
  }

  void _checkIsInitialized() {
    if (_box == null) {
      throw FilterRepositoryNotInitializedException();
    }
  }

  List<Login> get logins {
    _checkIsInitialized();
    try {
      return _box!.values.toList();
    } on Exception {
      throw Exception();
    }
  }

  Future<void> saveLogin(Login login) {
    _checkIsInitialized();
    try {
      return _box!.add(login);
    } on Exception {
      throw Exception();
    }
  }
}

class FilterRepositoryNotInitializedException implements Exception {}
