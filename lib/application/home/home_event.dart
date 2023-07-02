part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadTodosEvent extends HomeEvent {
  const LoadTodosEvent({required this.username});
  final String username;

  @override
  List<Object> get props => [username];
}
