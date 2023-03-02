part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  // @override
  // List<Object> get props => [];
}

class CheckFirstLaunchSignUp extends SignUpEvent {
  const CheckFirstLaunchSignUp();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CloseSignUpScreen extends SignUpEvent {
  const CloseSignUpScreen();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignUpWithGoolge extends SignUpEvent {
  const SignUpWithGoolge();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
