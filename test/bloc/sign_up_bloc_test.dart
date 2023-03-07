import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/sign_up/view_model/sign_up_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("Sign_up_bloc test state", () {
    late SignUpBloc signUpBloc;
    setUpAll(() {
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
