part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class CheckFirstLaunchSignUp extends SignUpEvent {
  const CheckFirstLaunchSignUp();
}

class CloseSignUpScreen extends SignUpEvent {
  const CloseSignUpScreen();
}

class SignUpWithFacebook extends SignUpEvent{
  const SignUpWithFacebook();
}