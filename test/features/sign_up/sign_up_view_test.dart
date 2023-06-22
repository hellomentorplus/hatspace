import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/sign_up/view/sign_up_view.dart';
import 'package:hatspace/features/sign_up/view_model/sign_up_bloc.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/view_models/authentication/authentication_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widget_tester_extension.dart';
import 'sign_up_view_test.mocks.dart';

@GenerateMocks([SignUpBloc, AuthenticationBloc])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const widget = SignUpScreen();
  final MockSignUpBloc mockSignUpBloc = MockSignUpBloc();
  final MockAuthenticationBloc authenticationBloc = MockAuthenticationBloc();

  setUpAll(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/shared_preferences'),
            (MethodCall methodCall) async {
      if (methodCall.method == 'getAll') {
        return <String, dynamic>{}; // set initial values here if desired
      }
      return null;
    });
    when(mockSignUpBloc.stream).thenAnswer((realInvocation) {
      // Bloc's using stream to return states
      return Stream.value(const FirstLaunchScreen(true));
    });
    when(mockSignUpBloc.state).thenAnswer((realInvocation) {
      return const FirstLaunchScreen(true);
    });
    when(mockSignUpBloc.add(const CloseSignUpScreen()))
        .thenAnswer((realInvocation) {
      return SharedPreferences.setMockInitialValues({'isFirstLaunch': false});
    });
  });

  testWidgets('Check close icon button', (WidgetTester tester) async {
    await tester.blocWrapAndPump<SignUpBloc>(mockSignUpBloc, widget);
    Padding wrapContainer = tester.firstWidget(find.byType(Padding));
    expect(wrapContainer.padding,
        const EdgeInsets.only(left: 16, right: 16, bottom: 71));
    // icon button
    expect(find.byType(IconButton), findsOneWidget);

    expect(
        find.ancestor(
            of: find.text('Continue with with Google'),
            matching: find.byType(SecondaryButton)),
        findsOneWidget);

    expect(
        find.ancestor(
            of: find.text('Continue with Facebook'),
            matching: find.byType(SecondaryButton)),
        findsOneWidget);

    expect(
        find.ancestor(
            of: find.text('Continue with email'),
            matching: find.byType(SecondaryButton)),
        findsOneWidget);

    expect(
        find.ancestor(
            of: find.text('Skip'), matching: find.byType(TextOnlyButton)),
        findsOneWidget);

    expect(find.textContaining('Sign in', findRichText: true), findsOneWidget);

    // SecondaryButton signUpWithGoogleButton = tester.widget(find.ancestor(
    //     of: find.text("Sign up with Google"),
    //     matching: find.byType(SecondaryButton)));
    // await tester.tap(find.byWidget(signUpWithGoogleButton));
    // SecondaryButton signUpWithFacebookButton = tester.widget(find.ancestor(
    //     of: find.text("Sign up with Facebook"),
    //     matching: find.byType(SecondaryButton)));
    //await tester.tap(find.byWidget(signUpWithFacebookButton));
    // SecondaryButton signUpWithEmailButton = tester.widget(find.ancestor(
    //     of: find.text("Sign up with email"),
    //     matching: find.byType(SecondaryButton)));
    // await tester.tap(find.byWidget(signUpWithEmailButton));
    // TextOnlyButton skipButton = tester.widget(find.ancestor(
    //     of: find.text("Skip"), matching: find.byType(TextOnlyButton)));
    // await tester.tap(find.byWidget(skipButton));
    RichText richText =
        tester.widget(find.textContaining('Sign in', findRichText: true));
    final span = richText.text as TextSpan;
    expect(span.children?.elementAt(1).toPlainText(), 'Sign in');
  });

  testWidgets('Verify button interaction', (WidgetTester widgetTester) async {
    const Widget widget = SignUpScreen();
    await widgetTester.blocWrapAndPump<SignUpBloc>(mockSignUpBloc, widget);
    // Test interaction with google Sign in
    await widgetTester
        .tap(find.widgetWithText(SecondaryButton, 'Sign up with Google'));
    await widgetTester.pumpAndSettle();
    verify(mockSignUpBloc.add(const SignUpWithGoogle()));
    // Test interaction with facebook Sign in
    await widgetTester
        .tap(find.widgetWithText(SecondaryButton, 'Sign up with Facebook'));
    await widgetTester.pumpAndSettle();
    verify(mockSignUpBloc.add(const SignUpWithFacebook()));
  });

  testWidgets('Skip event - detect first launch app',
      (WidgetTester tester) async {
    await tester.blocWrapAndPump<SignUpBloc>(mockSignUpBloc, widget);
    SharedPreferences.setMockInitialValues({});
    TextOnlyButton skipButton = tester.widget(find.ancestor(
        of: find.text('Skip'), matching: find.byType(TextOnlyButton)));
    await tester.tap(find.byWidget(skipButton));
    await tester.pumpAndSettle();
    SharedPreferences pref = await SharedPreferences.getInstance();
    expect(pref.getBool(isFirstLaunchConst), false);
  });
  testWidgets('Close button event - detect first launch app',
      (WidgetTester tester) async {
    await tester.blocWrapAndPump<SignUpBloc>(mockSignUpBloc, widget);
    SharedPreferences.setMockInitialValues({});
    IconButton closeButton = tester.widget(find.byType(IconButton));
    await tester.tap(find.byWidget(closeButton));
    await tester.pumpAndSettle();
    SharedPreferences pref = await SharedPreferences.getInstance();
    expectLater(pref.getBool(isFirstLaunchConst), false);
  });

  group('verify listener events', () {
    tearDown(() {
      reset(mockSignUpBloc);
      reset(authenticationBloc);
    });

    testWidgets('when state is SignUpStart, then show loading screen',
        (widgetTester) async {
      when(mockSignUpBloc.state).thenAnswer((realInvocation) => SignUpStart());
      when(mockSignUpBloc.stream)
          .thenAnswer((realInvocation) => Stream.value(SignUpStart()));

      const Widget widget = SignUpScreen();

      await widgetTester.blocWrapAndPump<SignUpBloc>(mockSignUpBloc, widget,
          infiniteAnimationWidget: true);

      expect(find.text('Loading...'), findsOneWidget);
    });

    testWidgets(
        'when state is FirstLaunchScreen and first launch is false, then return to previous screen',
        (widgetTester) async {
      when(mockSignUpBloc.state)
          .thenAnswer((realInvocation) => const FirstLaunchScreen(false));
      when(mockSignUpBloc.stream).thenAnswer(
          (realInvocation) => Stream.value(const FirstLaunchScreen(false)));

      const Widget widget = SignUpScreen();

      await widgetTester.blocWrapAndPump<SignUpBloc>(mockSignUpBloc, widget,
          infiniteAnimationWidget: true, useRouter: true);

      expect(find.byType(SignUpScreen), findsNothing);
    });

    testWidgets('when state is UserCancelled, then show toast message',
        (widgetTester) async {
      when(mockSignUpBloc.state)
          .thenAnswer((realInvocation) => UserCancelled());
      when(mockSignUpBloc.stream)
          .thenAnswer((realInvocation) => Stream.value(UserCancelled()));

      const Widget widget = SignUpScreen();

      await widgetTester.blocWrapAndPump<SignUpBloc>(mockSignUpBloc, widget,
          infiniteAnimationWidget: true);

      expect(find.text('Login Failed'), findsOneWidget);
      expect(
          find.text(
              'Unable to sign you in at the moment. Please try again later.'),
          findsOneWidget);

      await widgetTester.pump(const Duration(seconds: 6));

      // after more than 5 seconds, toast message dismisses
      expect(find.text('Login Failed'), findsNothing);
      expect(
          find.text(
              'Unable to sign you in at the moment. Please try again later.'),
          findsNothing);
    });

    testWidgets('when state is AuthenticationFailed, then show toast message',
        (widgetTester) async {
      when(mockSignUpBloc.state)
          .thenAnswer((realInvocation) => AuthenticationFailed());
      when(mockSignUpBloc.stream)
          .thenAnswer((realInvocation) => Stream.value(AuthenticationFailed()));

      const Widget widget = SignUpScreen();

      await widgetTester.blocWrapAndPump<SignUpBloc>(mockSignUpBloc, widget,
          infiniteAnimationWidget: true);

      expect(find.text('Login Failed'), findsOneWidget);
      expect(
          find.text(
              'Unable to sign you in at the moment. Please try again later.'),
          findsOneWidget);

      await widgetTester.pump(const Duration(seconds: 6));

      // after more than 5 seconds, toast message dismisses
      expect(find.text('Login Failed'), findsNothing);
      expect(
          find.text(
              'Unable to sign you in at the moment. Please try again later.'),
          findsNothing);
    });

    testWidgets(
        'when state is SignUpSuccess, then update authentication status',
        (widgetTester) async {
      when(authenticationBloc.state)
          .thenAnswer((realInvocation) => AuthenticationInitial());
      when(authenticationBloc.stream).thenAnswer(
          (realInvocation) => Stream.value(AuthenticationInitial()));

      when(mockSignUpBloc.state)
          .thenAnswer((realInvocation) => const SignUpSuccess());
      when(mockSignUpBloc.stream)
          .thenAnswer((realInvocation) => Stream.value(const SignUpSuccess()));

      const Widget widget = SignUpScreen();

      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<SignUpBloc>(
          create: (context) => mockSignUpBloc,
        ),
      ], widget, infiniteAnimationWidget: true, useRouter: true);

      // expect to send event to authentication bloc
      verify(authenticationBloc.add(ValidateAuthentication())).called(1);
    });
  });
}
