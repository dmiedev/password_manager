part of 'login_addition_bloc.dart';

abstract class LoginAdditionState {
  const LoginAdditionState();
}

class LoginAdditionInitial extends LoginAdditionState {
  const LoginAdditionInitial();
}

class LoginAdditionSaveInProgress extends LoginAdditionState {
  const LoginAdditionSaveInProgress();
}

class LoginAdditionSaveSuccess extends LoginAdditionState {
  const LoginAdditionSaveSuccess();
}

class LoginAdditionSaveFailure extends LoginAdditionState {
  const LoginAdditionSaveFailure();
}
