import 'package:bloc/bloc.dart';
import 'package:clipboard/clipboard.dart';
import 'package:equatable/equatable.dart';
import 'package:password_manager/home/home.dart';

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

  void _handleUserNameCopied(
    LoginDetailsUserNameCopied event,
    Emitter<LoginDetailsState> emit,
  ) {
    FlutterClipboard.copy(state.login.userName);
    emit(
      state.copyWith(
        action: () => LoginDetailsAction.userNameCopy,
      ),
    );
  }

  String _loadPassword() {
    // TODO(dmiedev): load password
    return 'password';
  }

  void _handlePasswordCopied(
    LoginDetailsPasswordCopied event,
    Emitter<LoginDetailsState> emit,
  ) {
    final password = state.password ?? _loadPassword();
    FlutterClipboard.copy(state.password!);
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
    final password = state.password ?? _loadPassword();
    emit(
      state.copyWith(
        action: () => null,
        passwordIsVisible: !state.passwordIsVisible,
        password: () => password,
      ),
    );
  }
}
