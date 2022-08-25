import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_addition_event.dart';
part 'login_addition_state.dart';

class LoginAdditionBloc extends Bloc<LoginAdditionEvent, LoginAdditionState> {
  LoginAdditionBloc() : super(LoginAdditionInitial()) {
    on<LoginAdditionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
