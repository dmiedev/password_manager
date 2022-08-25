part of 'login_addition_bloc.dart';

abstract class LoginAdditionEvent extends Equatable {
  const LoginAdditionEvent();

  @override
  List<Object> get props => [];
}

class LoginAdditionCompleted extends LoginAdditionEvent {
  const LoginAdditionCompleted({
    required this.serviceName,
    required this.userName,
    required this.password,
  });

  final String serviceName;
  final String userName;
  final String password;

  @override
  List<Object> get props => [serviceName, userName, password];
}
