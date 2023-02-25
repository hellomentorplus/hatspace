part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class SignUpWithGoolge extends AuthenticationEvent {
  const SignUpWithGoolge();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

