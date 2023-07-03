// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class UpdateTodosEvent extends HomeEvent {
  const UpdateTodosEvent({
    required this.task,
    required this.id,
    required this.status,
  });

  final String task;
  final String id;
  final bool status;

  @override
  List<Object> get props => [task, status, id];
}

class DeleteTodosEvent extends HomeEvent {
  const DeleteTodosEvent({
    required this.id,
  });

  final String id;

  @override
  List<Object> get props => [id];
}

class ToggleTodosEvent extends HomeEvent {
  const ToggleTodosEvent(
      {required this.task, required this.status, required this.id});

  final String task;
  final bool status;
  final String id;

  @override
  List<Object> get props => [task, status, id];
}
