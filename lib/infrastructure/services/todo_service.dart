import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_bloc/infrastructure/models/home/task.dart';

class TodoService {
  late Box<Task> _tasks;
  Future<void> init() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TaskAdapter());
    }
    _tasks = await Hive.openBox('tasksBox');
  }

  List<Task> getTasks(final String username) {
    final tasks = _tasks.values.where((element) => element.user == username);
    return tasks.toList();
  }

  Future<void> addTask(final String username, final String task) async {
    await _tasks.add(Task(user: username, task: task, completed: false));
  }

  Future<void> removeTask(final String username, final String task) async {
    final taskToRemove = _tasks.values.firstWhere((Task taskFromBox) =>
        taskFromBox.task == task && taskFromBox.user == username);

    await taskToRemove.delete();
  }

  Future<void> updateTask(
      final String username, final String task, final String id,
      {bool? completed}) async {
    final taskToUpdate =
        _tasks.values.firstWhere((Task taskFromBox) => taskFromBox.id == id);

    final updatedTask = Task(
      id: taskToUpdate.id,
      user: username,
      task: task,
      completed: completed ?? taskToUpdate.completed,
    );

    await _tasks.put(taskToUpdate.key, updatedTask);
  }
}
