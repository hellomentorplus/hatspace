part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class OnAppLaunchValidation extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class SkipSignUp extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class _ValidateAuthentication extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}