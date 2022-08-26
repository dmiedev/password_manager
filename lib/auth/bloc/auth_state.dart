part of 'auth_bloc.dart';

enum AuthStatus {
  none,
  screenLockNotSet,
  success,
  failure,
}

class AuthState {
  AuthState({required this.status});

  final AuthStatus status;
}
