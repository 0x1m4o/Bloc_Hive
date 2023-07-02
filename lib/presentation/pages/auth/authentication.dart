import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_bloc/application/auth/login_bloc.dart';
import 'package:hive_bloc/infrastructure/services/authentication_service.dart';
import 'package:hive_bloc/infrastructure/services/todo_service.dart';
import 'package:hive_bloc/presentation/pages/home/home.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _obscure = true;
  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
          RepositoryProvider.of<AuthenticationService>(context),
          RepositoryProvider.of<TodoService>(context))
        ..add(const RegisterServicesEvent()),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => HomePage(username: state.username)),
            );
          }
        },
        builder: (context, state) {
          if (state is LoginInitial) {
            return Scaffold(
              appBar: AppBar(title: const Text('Login')),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: usernameC,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your username',
                        labelText: 'Username',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: passwordC,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscure = !_obscure;
                            });
                          },
                          icon: Icon(_obscure
                              ? Icons.remove_red_eye_sharp
                              : Icons.remove_red_eye_outlined),
                        ),
                        hintText: 'Enter your password',
                        labelText: 'Password',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<LoginBloc>().add(
                              RunLoginEvent(
                                username: usernameC.text,
                                password: passwordC.text,
                              ),
                            );
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
