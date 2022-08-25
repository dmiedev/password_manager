import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_addition_event.dart';
part 'login_addition_state.dart';

class LoginAdditionBloc extends Bloc<LoginAdditionEvent, LoginAdditionState> {
  LoginAdditionBloc() : super(const LoginAdditionInitial()) {
    on<LoginAdditionCompleted>(_handleCompleted);
  }

  Future<void> _handleCompleted(
    LoginAdditionCompleted event,
    Emitter<LoginAdditionState> emit,
  ) async {
    emit(const LoginAdditionSaveInProgress());
    try {
      // TODO(dmiedev): save login data
      emit(const LoginAdditionSaveSuccess());
    } on Exception {
      emit(const LoginAdditionSaveFailure());
    }
  }
}
