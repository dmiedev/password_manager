import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:login_repository/login_repository.dart';

part 'login_details_event.dart';
part 'login_details_state.dart';

class LoginDetailsBloc extends Bloc<LoginDetailsEvent, LoginDetailsState> {
  LoginDetailsBloc({required Login login})
      : super(LoginDetailsState(login: login)) {
    on<LoginDetailsUserNameCopied>(_handleUserNameCopied);
    on<LoginDetailsPasswordCopied>(_handlePasswordCopied);
    on<LoginDetailsPasswordVisibilitySwitched>(
      _handlePasswordVisibilitySwitched,
    );
  }

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

  String _retrievePassword() {
    // TODO(dmiedev): load password
    return 'password';
  }

  Future<void> _handlePasswordCopied(
    LoginDetailsPasswordCopied event,
    Emitter<LoginDetailsState> emit,
  ) async {
    final password = state.password ?? _retrievePassword();
    await Clipboard.setData(ClipboardData(text: password));
    emit(
      state.copyWith(
        action: () => LoginDetailsAction.passwordCopy,
        password: () => password,
      ),
    );
  }

  void _handlePasswordVisibilitySwitched(
    LoginDetailsPasswordVisibilitySwitched event,
    Emitter<LoginDetailsState> emit,
  ) {
    final password = state.password ?? _retrievePassword();
    emit(
      state.copyWith(
        action: () => null,
        passwordIsVisible: !state.passwordIsVisible,
        password: () => password,
      ),
    );
  }
}
