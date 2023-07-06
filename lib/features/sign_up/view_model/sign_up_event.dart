part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
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
