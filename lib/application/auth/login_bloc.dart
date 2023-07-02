import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_bloc/infrastructure/services/authentication_service.dart';
import 'package:hive_bloc/infrastructure/services/todo_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationService authenticationService;
  final TodoService todoService;
  LoginBloc(this.authenticationService, this.todoService)
      : super(const LoginInitial()) {
    on<RunLoginEvent>((event, emit) async {
      final user = await authenticationService.authenticateUser(
          event.username, event.password);
      if (user != null) {
        emit(LoginSuccess(username: user));
      }
    });

    on<RegisterServicesEvent>((event, emit) async {
      await authenticationService.init();
      await todoService.init();

      emit(const LoginInitial());
    });
  }
}
