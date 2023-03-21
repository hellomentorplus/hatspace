part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class CheckFirstLaunchSignUp extends SignUpEvent {
  const CheckFirstLaunchSignUp();
  @override
  List<Object?> get props => [];
}

class CloseSignUpScreen extends SignUpEvent {
  const CloseSignUpScreen();
  @override
  List<Object?> get props => [];
}

class SignUpWithGoogle extends SignUpEvent {
  const SignUpWithGoogle();

  @override
  List<Object?> get props => [];
}

class SignUpWithFacebook extends SignUpEvent {
  const SignUpWithFacebook();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RetrySignUp extends SignUpEvent {
  const RetrySignUp();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
