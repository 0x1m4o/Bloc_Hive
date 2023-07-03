import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String id; // Updated to use String as the ID type

  @HiveField(1)
  final String user;

  @HiveField(2)
  final String task;

  @HiveField(3)
  final bool completed;

  Task({
    String? id, // Updated to accept an optional ID parameter
    required this.user,
    required this.task,
    required this.completed,
  }) : id = id ?? const Uuid().v4(); // Generate a UUID if no ID is provided
}
