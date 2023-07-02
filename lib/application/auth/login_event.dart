part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class RunLoginEvent extends LoginEvent {
  final String username;
  final String password;
  const RunLoginEvent({required this.username, required this.password});
  @override
  List<Object> get props => [username, password];
}

class RegisterServicesEvent extends LoginEvent {
  const RegisterServicesEvent();
  @override
  List<Object> get props => [];
}
