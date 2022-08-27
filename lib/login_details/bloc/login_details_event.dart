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
  const LoginDetailsPasswordCopied();
}

class LoginDetailsPasswordVisibilitySwitched extends LoginDetailsEvent {
  const LoginDetailsPasswordVisibilitySwitched({
    required this.dialogMessage,
  });

  final String dialogMessage;

  @override
  List<Object> get props => [dialogMessage];
}
