import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/bloc/verification/authentication_bloc.dart';

void main() {
  group('LoginBloc', () {
    test('initial state is LoginState', () {
      final authenticationBloc = AuthenticationBloc();
      expect(authenticationBloc.state, const SignUpState());
    });
    group('Sign up', () {
      blocTest<AuthenticationBloc, SignUpState>('',
          setUp: () {},
          build: () => AuthenticationBloc(),
          act: (bloc) {
            bloc
              ..add(const SignUpEmailChanged('email'))
              ..add(const SignUpPasswordChanged('password'));
          },
          expect: () => const <SignUpState>[
                SignUpState(
                    email: 'email',
                    password: '',
                    emailStatus: FieldError.Invalid,
                    passwordStatus: FieldError.Valid),
                SignUpState(
                    email: 'email',
                    password: 'password',
                    emailStatus: FieldError.Invalid,
                    passwordStatus: FieldError.Invalid),
              ]);
    });
  });
}
