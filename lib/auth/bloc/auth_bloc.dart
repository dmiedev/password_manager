import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthState(status: AuthStatus.none)) {
    on<AuthRequested>(_handleRequested);
  }

  final AuthRepository _authRepository;

  Future<void> _handleRequested(
    AuthRequested event,
    Emitter<AuthState> emit,
  ) async {
    late final AuthStatus status;
    try {
      await _authRepository.authenticate(message: event.displayMessage);
      status = AuthStatus.success;
    } on AuthenticationLockNotSetException {
      status = AuthStatus.screenLockNotSet;
    } on Exception {
      status = AuthStatus.failure;
    }
    emit(AuthState(status: status));
  }
}
