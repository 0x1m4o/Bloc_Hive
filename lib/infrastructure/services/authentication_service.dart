import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_bloc/infrastructure/models/auth/user.dart';

class AuthenticationService {
  late Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox('usersBox');
    await _users.clear();
    await _users.add(User(username: 'test', password: 'test'));
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
}
