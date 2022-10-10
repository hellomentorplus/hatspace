part of 'authentication_bloc.dart';

enum FieldError { Invalid, Valid }

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class SignUpState extends AuthenticationState {
  const SignUpState(
      {this.email = '',
      this.password = '',
      this.emailStatus = FieldError.Valid,
      this.passwordStatus = FieldError.Valid});

  final String email;
  final String password;
  final FieldError emailStatus;
  final FieldError passwordStatus;

  SignUpState copyWith(
      {String? email,
      String? password,
      FieldError? emailstatus,
      FieldError? passwordstatus}) {
    return SignUpState(
        email: email ?? this.email,
        password: password ?? this.password,
        emailStatus: emailstatus ?? this.emailStatus,
        passwordStatus: passwordstatus ?? this.passwordStatus);
  }

  @override
  List<Object> get props => [email, password, emailStatus, passwordStatus];
}
