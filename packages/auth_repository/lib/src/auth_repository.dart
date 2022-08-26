import 'package:auth_repository/src/exceptions.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error_codes;
import 'package:local_auth/local_auth.dart';

class AuthRepository {
  AuthRepository({LocalAuthentication? auth}) {
    _auth = auth ?? LocalAuthentication();
  }

  late final LocalAuthentication _auth;

  Future<void> authenticate({required String message}) async {
    final bool didAuthenticate;
    try {
      // On Android, error dialogs do not show up.
      // TODO(dmiedev): https://github.com/flutter/flutter/issues/96646
      didAuthenticate = await _auth.authenticate(
        localizedReason: message,
        // Error dialogs are turned off for now so the app can show one single
        // custom dialog both on Android and iOS.
        options: const AuthenticationOptions(useErrorDialogs: false),
      );
    } on PlatformException catch (exception) {
      if (exception.code == auth_error_codes.passcodeNotSet ||
          exception.code == auth_error_codes.notEnrolled ||
          exception.code == auth_error_codes.notAvailable) {
        throw AuthenticationLockNotSetException();
      }
      throw AuthenticationFailureException();
    } on Exception {
      throw AuthenticationFailureException();
    }
    if (!didAuthenticate) {
      throw AuthenticationFailureException();
    }
  }
}
