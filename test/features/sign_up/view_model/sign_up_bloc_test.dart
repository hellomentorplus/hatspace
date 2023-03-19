import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/sign_up/view_model/sign_up_bloc.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sign_up_bloc_test.mocks.dart';

@GenerateMocks([AuthenticationService])
void main() {
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();

  setUpAll(() {
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
  });

  TestWidgetsFlutterBinding.ensureInitialized();
  // setupFirebaseCoreMocks(); // Not relate to HS 51 - Need to add to perform test coverage
  group("Sign_up_bloc test state", () {
    late SignUpBloc signUpBloc;
    setUpAll(() async {
      // Unexpected bugs - happended when running test coverage
      signUpBloc = SignUpBloc();
      const MethodChannel('plugins.flutter.io/shared_preferences')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        if (methodCall.method == 'getAll') {
          return <String, dynamic>{}; // set initial values here if desired
        }
        return null;
      });
    });
    test("initial test", () {
      expect(SignUpBloc().state, const SignUpInitial());
    });

    blocTest<SignUpBloc, SignUpState>(
        "Return FirstLaunchScreen state with isFirstLaunch is true when first open app with CheckFirstLaunchSignUp event",
        build: () => SignUpBloc(),
        act: ((bloc) {
          SharedPreferences.setMockInitialValues({});
          bloc.add(const CheckFirstLaunchSignUp());
        }),
        expect: () {
          return [const FirstLaunchScreen(true)];
        });
    blocTest<SignUpBloc, SignUpState>(
      'Return FirstLaunchScreen with isFirstLaunch is false when trigger CloseSignUPScreen Event',
      build: () => SignUpBloc(),
      act: (signUpBloc) {
        SharedPreferences.setMockInitialValues({});
        signUpBloc.add(const CloseSignUpScreen());
      },
      expect: () {
        return [const FirstLaunchScreen(false)];
      },
    );

    tearDown(() {
      signUpBloc.close();
    });
  });

  group('test sign up with google', () {
    blocTest<SignUpBloc, SignUpState>(
      'when signup with google success, then return success state',
      build: () => SignUpBloc(),
      setUp: () {
        when(authenticationService.signUpWithGoogle()).thenAnswer(
            (realInvocation) => Future.value(
                UserDetail(uid: 'uid', phone: 'phone', email: 'email')));
      },
      act: (bloc) => bloc.add(const SignUpWithGoogle()),
      expect: () => [isA<SignUpSuccess>()],
    );

    blocTest(
      'when sign up with google failed with UserCancelException, then return UserCancelled',
      build: () => SignUpBloc(),
      setUp: () => when(authenticationService.signUpWithGoogle())
          .thenThrow(UserCancelException()),
      act: (bloc) => bloc.add(const SignUpWithGoogle()),
      expect: () => [isA<UserCancelled>()],
    );

    blocTest(
        'when signup with google failed with UserNotFoundException, then return AuthenticationFailed',
        build: () => SignUpBloc(),
        setUp: () => when(authenticationService.signUpWithGoogle())
            .thenThrow(UserNotFoundException()),
        act: (bloc) => bloc.add(const SignUpWithGoogle()),
        expect: () => [isA<AuthenticationFailed>()]);

    blocTest(
      'when signup with google failed with unknown error, then return AuthenticationFailed',
      build: () => SignUpBloc(),
      setUp: () => when(authenticationService.signUpWithGoogle())
          .thenThrow(PlatformException(code: '1234')),
      act: (bloc) => bloc.add(const SignUpWithGoogle()),
      expect: () => [isA<AuthenticationFailed>()],
    );

    //Facebook bloc test
    blocTest('when sign up with facebook success, then return SignUpSuccess',
        build: () => SignUpBloc(),
        setUp: () {
          when(authenticationService.signUpWithFacebook())
              .thenAnswer((realInvocation) {
            return Future.value(
                UserDetail(uid: 'uid', phone: 'phone', email: 'email'));
          });
        },
        act: (bloc) => bloc.add(const SignUpWithFacebook()),
        expect: () => [isA<SignUpSuccess>()]);
  });

  blocTest("when sign up with facebook with canceled response",
      build: () => SignUpBloc(),
      setUp: () => when(authenticationService.signUpWithFacebook())
          .thenThrow(UserCancelException()),
      act: (bloc) => bloc.add(const SignUpWithFacebook()),
      expect: () => [isA<UserCancelled>()]);

  blocTest("when sign up with facebook with canceled response",
      build: () => SignUpBloc(),
      setUp: () => when(authenticationService.signUpWithFacebook())
          .thenThrow(UserNotFoundException()),
      act: (bloc) => bloc.add(const SignUpWithFacebook()),
      expect: () => [isA<UserCancelled>()]);
  blocTest("when sign up with facebook with canceled response",
      build: () => SignUpBloc(),
      setUp: () => when(authenticationService.signUpWithFacebook())
          .thenThrow(AuthenticationFailed()),
      act: (bloc) => bloc.add(const SignUpWithFacebook()),
      expect: () => [isA<UserCancelled>()]);

  test('test state and event', () {
    CheckFirstLaunchSignUp firstLaunchSignUp = const CheckFirstLaunchSignUp();

    expect(firstLaunchSignUp.props.length, 0);

    CloseSignUpScreen closeSignUpScreen = const CloseSignUpScreen();
    expect(closeSignUpScreen.props.length, 0);

    SignUpInitial signUpInitial = const SignUpInitial();
    expect(signUpInitial.props.length, 0);

    FirstLaunchScreen firstLaunchScreenTrue = const FirstLaunchScreen(true);
    expect(firstLaunchScreenTrue.props.length, 1);
    expect(firstLaunchScreenTrue.props.first, true);

    FirstLaunchScreen firstLaunchScreenFalse = const FirstLaunchScreen(false);
    expect(firstLaunchScreenFalse.props.length, 1);
    expect(firstLaunchScreenFalse.props.first, false);
  });
}
