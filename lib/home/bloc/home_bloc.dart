import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_repository/login_repository.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required LoginRepository loginRepository,
  })  : _loginRepository = loginRepository,
        super(const HomeInitial()) {
    on<HomeLoaded>(_handleLoaded);
  }

  final LoginRepository _loginRepository;

  void _handleLoaded(HomeLoaded event, Emitter<HomeState> emit) {
    try {
      emit(HomeLoadSuccess(logins: _loginRepository.logins));
    } on Exception {
      emit(const HomeLoadFailure());
    }
  }
}
