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
  }
}
