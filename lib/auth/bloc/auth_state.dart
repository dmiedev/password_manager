part of 'auth_bloc.dart';

enum AuthStatus {
  none,
  success,
  failure,
}

class AuthState extends Equatable {
  const AuthState({required this.status});

  final AuthStatus status;

  @override
  List<Object> get props => [status];
}
