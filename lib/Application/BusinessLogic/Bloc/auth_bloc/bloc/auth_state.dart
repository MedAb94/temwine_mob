part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Authenticating extends AuthState {}

class Authenticated extends AuthState {
  final UserDataEntity userDataEntity;

  const Authenticated({required this.userDataEntity});

  @override
  List<Object> get props => [userDataEntity];
}

class AuthError extends AuthState {
  final String errorMessage;

  const AuthError({required this.errorMessage});
}

class UnAuthenticating extends AuthState {}

class UnAuthenticated extends AuthState {}

class UnAuthenticated2 extends AuthState {}
