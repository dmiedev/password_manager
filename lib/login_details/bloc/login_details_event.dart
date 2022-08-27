part of 'login_details_bloc.dart';

abstract class LoginDetailsEvent extends Equatable {
  const LoginDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoginDetailsUserNameCopied extends LoginDetailsEvent {
  const LoginDetailsUserNameCopied();
}

class LoginDetailsPasswordCopied extends LoginDetailsEvent {
  const LoginDetailsPasswordCopied({
    required this.authDialogMessage,
  });

  final String authDialogMessage;

  @override
  List<Object> get props => [authDialogMessage];
}

class LoginDetailsPasswordVisibilitySwitched extends LoginDetailsEvent {
  const LoginDetailsPasswordVisibilitySwitched({
    required this.authDialogMessage,
  });

  final String authDialogMessage;

  @override
  List<Object> get props => [authDialogMessage];
}
