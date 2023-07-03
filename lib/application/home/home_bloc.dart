import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_bloc/infrastructure/services/todo_service.dart';
import '../../infrastructure/models/home/task.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TodoService todoService;
  HomeBloc({required this.todoService}) : super(HomeInitial()) {
    on<LoadTodosEvent>((event, emit) {
      final todos = todoService.getTasks(event.username);
      emit(TodosLoadedState(tasks: todos, username: event.username));
    });

    on<AddTodosEvent>((event, emit) async {
      final currentState = state as TodosLoadedState;
      await todoService.addTask(currentState.username, event.task);
      add(LoadTodosEvent(username: currentState.username));
    });

    on<UpdateTodosEvent>((event, emit) async {
      final currentState = state as TodosLoadedState;
      await todoService.updateTask(currentState.username, event.task, event.id);
      add(LoadTodosEvent(username: currentState.username));
    });
    on<DeleteTodosEvent>((event, emit) async {
      final currentState = state as TodosLoadedState;
      await todoService.removeTask(event.id);
      add(LoadTodosEvent(username: currentState.username));
    });

    on<ToggleTodosEvent>((event, emit) async {
      final currentState = state as TodosLoadedState;
      await todoService.updateTask(currentState.username, event.task, event.id,
          completed: !event.status);
      add(LoadTodosEvent(username: currentState.username));
    });
  }
}
