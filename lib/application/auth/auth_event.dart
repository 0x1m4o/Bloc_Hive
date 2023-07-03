part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  const LoginEvent({required this.username, required this.password});
  @override
  List<Object> get props => [username, password];
}

class RegisterEvent extends AuthEvent {
  final String username;
  final String password;
  const RegisterEvent({required this.username, required this.password});
  @override
  List<Object> get props => [username, password];
}

class InitEvent extends AuthEvent {
  const InitEvent();
  @override
  List<Object> get props => [];
}
