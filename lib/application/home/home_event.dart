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

class AddTodosEvent extends HomeEvent {
  const AddTodosEvent({required this.task});

  final String task;

  @override
  List<Object> get props => [task];
}

class ToggleTodosEvent extends HomeEvent {
  const ToggleTodosEvent({required this.task});

  final String task;

  @override
  List<Object> get props => [task];
}
