import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, SignUpState> {
  AuthenticationBloc() : super(const SignUpState()) {
    on<SignUpEmailChanged>(_onEmailChanged);

    on<SignUpPasswordChanged>(_onPasswordChanged);
  }

  void _onEmailChanged(SignUpEmailChanged event, Emitter<SignUpState> emit) {
    final String emailInput = event.email;
    final FieldError statusOutput;
    RegExp exp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!exp.hasMatch(emailInput)) {
      statusOutput = FieldError.Invalid;
    } else {
      statusOutput = FieldError.Valid;
    }

    emit(state.copyWith(email: emailInput, emailstatus: statusOutput));
  }

  void _onPasswordChanged(
      SignUpPasswordChanged event, Emitter<SignUpState> emit) {
    final String passwordInput = event.password;
    final FieldError statusOutput;
    RegExp exp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    if (!exp.hasMatch(passwordInput)) {
      statusOutput = FieldError.Invalid;
    } else {
      statusOutput = FieldError.Valid;
    }

    emit(state.copyWith(password: passwordInput, passwordstatus: statusOutput));
  }
}
