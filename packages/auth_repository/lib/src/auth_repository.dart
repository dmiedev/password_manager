import 'package:auth_repository/src/exceptions.dart';
import 'package:local_auth/local_auth.dart';

class AuthRepository {
  AuthRepository({LocalAuthentication? auth}) {
    _auth = auth ?? LocalAuthentication();
  }

  late final LocalAuthentication _auth;

  Future<void> authenticate({required String message}) async {
    final bool didAuthenticate;
    try {
      didAuthenticate = await _auth.authenticate(localizedReason: message);
    } on Exception {
      throw AuthenticationFailureException();
    }
    if (!didAuthenticate) {
      throw AuthenticationFailureException();
    }
  }
}
