part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  final String? error;
  const AuthInitial({this.error});

  @override
  List<Object?> get props => [error];
}

class LoginSuccess extends AuthState {
  final String username;
  const LoginSuccess({required this.username});

  @override
  List<Object?> get props => [username];
}
