import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_bloc/infrastructure/models/home/task.dart';

class TodoService {
  late Box<Task> _tasks;
  Future<void> init() async {
    Hive.registerAdapter(TaskAdapter());
    _tasks = await Hive.openBox('tasksBox');
    await _tasks.clear();
    await _tasks.add(Task(user: 'test', task: 'test1', completed: false));
    await _tasks.add(Task(user: 'test', task: 'test2', completed: false));
  }

  List<Task> getTasks(final String username) {
    final tasks = _tasks.values.where((element) => element.user == username);
    return tasks.toList();
  }

  void addTask(final String username, final String task) {
    _tasks.add(Task(user: username, task: task, completed: false));
  }

  void removeTask(final String username, final String task) async {
    final taskToRemove = _tasks.values.firstWhere((Task taskFromBox) =>
        taskFromBox.task == task && taskFromBox.user == username);

    await taskToRemove.delete();
  }

  void updateTask(final String username, final String task,
      {final bool? completed}) async {
    final taskToEdit = _tasks.values.firstWhere((Task taksFromBox) =>
        taksFromBox.task == task && taksFromBox.user == username);

    final index = taskToEdit.key as int;
    await _tasks.put(
        index,
        Task(
            user: username,
            task: task,
            completed: completed ?? taskToEdit.completed));
  }
}
