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

class SignUpWithGoolge extends SignUpEvent {
  const SignUpWithGoolge();

  @override
  List<Object?> get props => [];
}
