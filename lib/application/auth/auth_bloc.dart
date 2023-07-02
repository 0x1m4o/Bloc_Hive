import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_bloc/infrastructure/services/authentication_service.dart';
import 'package:hive_bloc/infrastructure/services/todo_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationService authenticationService;
  final TodoService todoService;
  AuthBloc(this.authenticationService, this.todoService)
      : super(const AuthInitial()) {
    on<RunLoginEvent>((event, emit) async {
      final user = await authenticationService.authenticateUser(
          event.username, event.password);
      if (user != null) {
        emit(LoginSuccess(username: user));
      }
    });
    on<RunRegisterEvent>((event, emit) async {
      final results = await authenticationService.createUser(
          event.username, event.password);
      switch (results) {
        case UserCreationResult.success:
          emit(LoginSuccess(username: event.username));
          break;
        case UserCreationResult.failure:
          emit(const AuthInitial(error: 'There is an Error'));
          break;
        case UserCreationResult.alreadyExists:
          emit(const AuthInitial(error: 'User already Exist'));
          break;
        default:
      }
    });

    on<RegisterServicesEvent>((event, emit) async {
      await authenticationService.init();
      await todoService.init();

      emit(const AuthInitial());
    });
  }
}
