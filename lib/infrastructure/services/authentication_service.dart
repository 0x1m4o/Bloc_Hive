import 'package:hive_bloc/infrastructure/models/home/task.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_bloc/infrastructure/models/auth/user.dart';

enum UserCreationResult { success, failure, alreadyExists }

class AuthenticationService {
  late Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox('usersBox');
  }

  Future<String?> authenticateUser(String username, String password) async {
    final success = _users.values.any((element) =>
        element.username == username && element.password == password);
    if (success) {
      return username;
    } else {
      return null;
    }
  }

  Future<UserCreationResult> createUser(
      String username, String password) async {
    final alreadyExists = _users.values.any(
        (User user) => user.username.toLowerCase() == username.toLowerCase());
    if (alreadyExists) {
      return UserCreationResult.alreadyExists;
    } else {
      try {
        _users.add(User(username: username, password: password));
        return UserCreationResult.success;
      } catch (e) {
        return UserCreationResult.failure;
      }
    }
  }
}
