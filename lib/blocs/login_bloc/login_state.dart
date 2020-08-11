part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class Empty extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailed extends LoginState {}
