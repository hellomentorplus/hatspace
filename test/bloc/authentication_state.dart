// import 'package:hatspace/bloc/bloc/authentication_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/bloc/verification/authentication_bloc.dart';

void main() {
  const email = 'emaail';
  const password = 'password';
  group('LoginState', () {
    test('supports value comparisons', () {
      expect(const SignUpState(), const SignUpState());
    });

    test('returns same object when no properties are passed', () {
      expect(const SignUpState().copyWith(), const SignUpState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        const SignUpState().copyWith(
            emailstatus: FieldError.Valid, passwordstatus: FieldError.Invalid),
        const SignUpState(),
      );
    });

    test('returns object with updated username when username is passed', () {
      expect(
        const SignUpState().copyWith(email: email),
        const SignUpState(email: email),
      );
    });

    test('returns object with updated password when password is passed', () {
      expect(
        const SignUpState().copyWith(password: password),
        const SignUpState(password: password),
      );
    });
  });
}
