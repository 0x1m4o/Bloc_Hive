import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_bloc/application/auth/auth_bloc.dart';
import 'package:hive_bloc/infrastructure/services/authentication_service.dart';
import 'package:hive_bloc/infrastructure/services/todo_service.dart';
import 'package:hive_bloc/presentation/pages/home/home.dart';
import 'package:hive_bloc/presentation/pages/auth/login/login.dart';
import 'package:hive_bloc/presentation/pages/auth/widgets/password_textfield.dart';
import 'package:hive_bloc/presentation/pages/auth/widgets/user_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  @override
  void dispose() {
    usernameC.clear();
    passwordC.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
          RepositoryProvider.of<AuthenticationService>(context),
          RepositoryProvider.of<TodoService>(context)),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => HomePage(username: state.username)),
            );
          } else if (state is AuthInitial) {
            if (state.error != null) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Error'),
                  content: Text(state.error!),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is AuthInitial) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 500,
                      color: Colors.brown.shade400,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: double.infinity,
                              child: Text(
                                'Register',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            UserTextField(usernameC: usernameC),
                            const SizedBox(
                              height: 20,
                            ),
                            PasswordTextField(
                              passwordC: passwordC,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              alignment: Alignment.centerRight,
                              child: OutlinedButton(
                                onPressed: () {
                                  context.read<AuthBloc>().add(RegisterEvent(
                                      username: usernameC.text,
                                      password: passwordC.text));
                                },
                                style: const ButtonStyle(
                                    side: MaterialStatePropertyAll(
                                        BorderSide(width: 1))),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Already have an account? '),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage()));
                                      },
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            color: Colors.blue.shade400),
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
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
