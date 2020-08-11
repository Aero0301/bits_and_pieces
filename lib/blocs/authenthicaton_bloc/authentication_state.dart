part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final DocumentReference documentReference;
  final FirebaseUser firebaseUser;

  const Authenticated({this.documentReference, this.firebaseUser});

  @override
  List<Object> get props => [firebaseUser];
}

class Unauthenticated extends AuthenticationState {}