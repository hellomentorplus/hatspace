part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticateSuccess extends AuthenticationState {
  const AuthenticateSuccess();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthenticateFailed extends AuthenticationState {
  String message;
  AuthenticateFailed(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
