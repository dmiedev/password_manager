import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:login_repository/login_repository.dart';

part 'login_details_event.dart';
part 'login_details_state.dart';

class LoginDetailsBloc extends Bloc<LoginDetailsEvent, LoginDetailsState> {
  LoginDetailsBloc({
    required Login login,
    required LoginRepository loginRepository,
    required AuthRepository authRepository,
  })  : _loginRepository = loginRepository,
        _authRepository = authRepository,
        super(LoginDetailsState(login: login)) {
    on<LoginDetailsUserNameCopied>(_handleUserNameCopied);
    on<LoginDetailsPasswordCopied>(_handlePasswordCopied);
    on<LoginDetailsPasswordVisibilitySwitched>(
      _handlePasswordVisibilitySwitched,
    );
  }

  final LoginRepository _loginRepository;
  final AuthRepository _authRepository;

  Future<void> _handleUserNameCopied(
    LoginDetailsUserNameCopied event,
    Emitter<LoginDetailsState> emit,
  ) async {
    await Clipboard.setData(ClipboardData(text: state.login.userName));
    emit(
      state.copyWith(
        action: () => LoginDetailsAction.userNameCopy,
      ),
    );
  }

  Future<String> _retrievePassword() async {
    return await _loginRepository.getPassword(login: state.login) ?? '';
  }

  Future<void> _handlePasswordCopied(
    LoginDetailsPasswordCopied event,
    Emitter<LoginDetailsState> emit,
  ) async {
    if (!state.passwordIsVisible) {
      try {
        await _authRepository.authenticate(message: event.authDialogMessage);
      } on Exception {
        emit(
          state.copyWith(
            action: () => LoginDetailsAction.authenticationFailure,
          ),
        );
        return;
      }
    }
    final password = state.password ?? await _retrievePassword();
    await Clipboard.setData(ClipboardData(text: password));
    emit(
      state.copyWith(
        action: () => LoginDetailsAction.passwordCopy,
        password: () => password,
      ),
    );
  }

  Future<void> _handlePasswordVisibilitySwitched(
    LoginDetailsPasswordVisibilitySwitched event,
    Emitter<LoginDetailsState> emit,
  ) async {
    if (!state.passwordIsVisible) {
      try {
        await _authRepository.authenticate(message: event.authDialogMessage);
      } on Exception {
        emit(
          state.copyWith(
            action: () => LoginDetailsAction.authenticationFailure,
          ),
        );
        return;
      }
    }
    final password = state.password ?? await _retrievePassword();
    emit(
      state.copyWith(
        action: () => null,
        passwordIsVisible: !state.passwordIsVisible,
        password: () => password,
      ),
    );
  }
}
