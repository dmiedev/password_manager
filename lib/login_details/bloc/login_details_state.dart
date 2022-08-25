part of 'login_details_bloc.dart';

enum LoginDetailsAction {
  userNameCopy,
  passwordCopy,
}

class LoginDetailsState extends Equatable {
  const LoginDetailsState({
    required this.login,
    this.password,
    this.passwordIsVisible = false,
    this.action,
  });

  final Login login;
  final String? password;
  final bool passwordIsVisible;
  final LoginDetailsAction? action;

  LoginDetailsState copyWith({
    Login? login,
    String? Function()? password,
    bool? passwordIsVisible,
    LoginDetailsAction? Function()? action,
  }) {
    return LoginDetailsState(
      login: login ?? this.login,
      password: password != null ? password() : this.password,
      passwordIsVisible: passwordIsVisible ?? this.passwordIsVisible,
      action: action != null ? action() : this.action,
    );
  }

  @override
  List<Object?> get props => [
        login,
        password,
        passwordIsVisible,
        action,
      ];
}
