import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_bloc/application/auth/login_bloc.dart';
import 'package:hive_bloc/infrastructure/services/authentication_service.dart';
import 'package:hive_bloc/infrastructure/services/todo_service.dart';
import 'package:hive_bloc/presentation/pages/auth/authentication.dart';
import './presentation/pages/home/home.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider(
        create: (context) => AuthenticationService(),
      ),
      RepositoryProvider(
        create: (context) => TodoService(),
      )
    ], child: const MaterialApp(home: AuthPage()));
  }
}
