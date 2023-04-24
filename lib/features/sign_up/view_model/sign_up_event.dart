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

class OnSignUp extends SignUpEvent {
  final SignUpType signUpType;
  const OnSignUp({required this.signUpType});
  @override
  List<Object?> get props => [signUpType];
}
