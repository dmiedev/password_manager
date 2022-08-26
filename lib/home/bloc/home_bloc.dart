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
    on<HomeSubscriptionRequested>(_handleSubscriptionRequested);
  }

  final LoginRepository _loginRepository;

  Future<void> _handleSubscriptionRequested(
    HomeSubscriptionRequested event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await emit.forEach<List<Login>>(
        _loginRepository.loginStream,
        onData: (logins) => HomeLoadSuccess(logins: logins),
      );
    } on Exception {
      emit(const HomeLoadFailure());
    }
  }
}
