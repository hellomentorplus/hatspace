part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthenticationState {
  final UserDetail userDetail;

  const AuthenticatedState(this.userDetail);
  @override
  List<Object?> get props => [];
}

class AnonymousState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}
