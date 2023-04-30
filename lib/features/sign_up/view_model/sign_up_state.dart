part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

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

class UserCancelled extends SignUpState {
  @override
  List<Object?> get props => [];
}

class AuthenticationFailed extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpStart extends SignUpState {
  @override
  List<Object?> get props => [];
}

class UserRolesUnavailable extends SignUpState {
  const UserRolesUnavailable();
  @override
  List<Object?> get props => [];
}

//NOTE: THis changes relate to HS-101
// TODO: Remove these line of code when finish reviewing
// class UserRolesAvailable extends SignUpState {
//   const UserRolesAvailable();
//   @override
//   List<Object?> get props => [];
// }

class SignUpSuccess extends SignUpState {
  const SignUpSuccess();
  @override
  List<Object?> get props => [];
}
