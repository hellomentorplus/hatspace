part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class ValidateAuthentication extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}
