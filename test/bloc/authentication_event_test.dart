import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/bloc/verification/authentication_bloc.dart';

void main() {
  const email = 'mock-email';
  const password = 'mock-password';
  group('LoginEvent', () {
    group('SignUpEmailChanged', () {
      test('supports value comparisons', () {
        expect(
            const SignUpEmailChanged(email), const SignUpEmailChanged(email));
      });
    });

    group('SignUpPasswordChanged', () {
      test('supports value comparisons', () {
        expect(const SignUpPasswordChanged(password),
            const SignUpPasswordChanged(password));
      });
    });
  });
}
