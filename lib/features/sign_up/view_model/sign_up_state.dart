part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

@immutable
class SignUpInitial extends SignUpState {
  const SignUpInitial();
  @override
  List<Object> get props => [];
}

class FirstLaunchScreen extends SignUpState {
  final bool isFirstLaunch;
  const FirstLaunchScreen(this.isFirstLaunch);
  @override
  List<Object> get props => [isFirstLaunch];
}

class SignUpSuccess extends SignUpState {
  const SignUpSuccess();
  @override
  List<Object?> get props => [];
}
