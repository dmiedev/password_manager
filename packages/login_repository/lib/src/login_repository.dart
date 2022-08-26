import 'package:hive/hive.dart';
import 'package:login_repository/src/exceptions.dart';
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
      throw LoginRepositoryNotInitializedException();
    }
  }

  List<Login> get logins {
    _checkIsInitialized();
    return _box!.values.toList();
  }

  Future<void> saveLogin(Login login) {
    _checkIsInitialized();
    try {
      return _box!.add(login);
    } on Exception {
      throw LoginSaveException();
    }
  }
}
