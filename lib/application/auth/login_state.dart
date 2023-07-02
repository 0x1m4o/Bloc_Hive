part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginState {
  final String username;
  const LoginSuccess({required this.username});

  @override
  List<Object?> get props => [username];
}
