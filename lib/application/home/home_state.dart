part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class TodosLoadedState extends HomeState {
  final List<Task> tasks;
  final String username;
  TodosLoadedState({required this.tasks, required this.username});
  @override
  List<Object> get props => [username, tasks];
}
