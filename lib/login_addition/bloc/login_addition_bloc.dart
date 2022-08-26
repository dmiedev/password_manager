import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_repository/login_repository.dart';

part 'login_addition_event.dart';
part 'login_addition_state.dart';

class LoginAdditionBloc extends Bloc<LoginAdditionEvent, LoginAdditionState> {
  LoginAdditionBloc({
    required LoginRepository loginRepository,
  })  : _loginRepository = loginRepository,
        super(const LoginAdditionInitial()) {
    on<LoginAdditionCompleted>(_handleCompleted);
  }

  final LoginRepository _loginRepository;

  Future<void> _handleCompleted(
    LoginAdditionCompleted event,
    Emitter<LoginAdditionState> emit,
  ) async {
    emit(const LoginAdditionSaveInProgress());
    try {
      await _loginRepository.saveLoginData(
        login: Login(
          serviceName: event.serviceName,
          userName: event.userName,
        ),
        password: event.password,
      );
      emit(const LoginAdditionSaveSuccess());
    } on Exception {
      emit(const LoginAdditionSaveFailure());
    }
  }
}
