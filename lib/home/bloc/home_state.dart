part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoadInProgress extends HomeState {
  const HomeLoadInProgress();
}

class HomeLoadSuccess extends HomeState {
  const HomeLoadSuccess({required this.logins});

  final List<Login> logins;

  @override
  List<Object?> get props => [logins];
}

class HomeLoadFailure extends HomeState {
  const HomeLoadFailure();
}
