part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class RunLoginEvent extends AuthEvent {
  final String username;
  final String password;
  const RunLoginEvent({required this.username, required this.password});
  @override
  List<Object> get props => [username, password];
}

class RunRegisterEvent extends AuthEvent {
  final String username;
  final String password;
  const RunRegisterEvent({required this.username, required this.password});
  @override
  List<Object> get props => [username, password];
}

class RegisterServicesEvent extends AuthEvent {
  const RegisterServicesEvent();
  @override
  List<Object> get props => [];
}
