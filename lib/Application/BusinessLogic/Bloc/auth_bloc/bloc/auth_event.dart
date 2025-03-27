part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthInit extends AuthEvent {}

class SignIn extends AuthEvent {
  final UserEntity userCreds;

  const SignIn({required this.userCreds});

  @override
  List<Object> get props => [userCreds];
}

class SignOut extends AuthEvent {
  final bool removeTokenOnly;
  final bool makeServerRequest;

  const SignOut({this.removeTokenOnly = false, this.makeServerRequest = true});

  @override
  List<Object> get props => [removeTokenOnly, makeServerRequest];
}
