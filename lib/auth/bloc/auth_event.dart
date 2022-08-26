part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthRequested extends AuthEvent {
  const AuthRequested({required this.displayMessage});

  final String displayMessage;

  @override
  List<Object> get props => [displayMessage];
}
