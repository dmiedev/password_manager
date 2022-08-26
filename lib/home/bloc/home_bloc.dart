import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_repository/login_repository.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<HomeLoaded>(_handleLoaded);
  }

  void _handleLoaded(HomeLoaded event, Emitter<HomeState> emit) {
    if (state is HomeLoadInProgress) {
      return;
    }
    emit(const HomeLoadInProgress());
    try {
      // TODO(dmiedev): load real logins
      final logins = [
        Login(serviceName: 'Service A', userName: 'User A'),
        Login(serviceName: 'Service B', userName: 'User B'),
      ];
      emit(HomeLoadSuccess(logins: logins));
    } on Exception {
      emit(const HomeLoadFailure());
    }
  }
}
