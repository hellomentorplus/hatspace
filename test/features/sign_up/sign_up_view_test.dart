import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/sign_up/view/sign_up_view.dart';
import 'package:hatspace/features/sign_up/view_model/sign_up_bloc.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/view_models/authentication/authentication_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widget_tester_extension.dart';
import 'sign_up_view_test.mocks.dart';

@GenerateMocks(
    [SignUpBloc, AuthenticationBloc, StorageService, AuthenticationService])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const widget = SignUpScreen();
  final MockSignUpBloc mockSignUpBloc = MockSignUpBloc();
  final MockAuthenticationBloc authenticationBloc = MockAuthenticationBloc();
  final MockStorageService storageService = MockStorageService();
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();

  setUpAll(() async {
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
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

  testWidgets('Check skip icon button', (WidgetTester tester) async {
    await tester.blocWrapAndPump<SignUpBloc>(mockSignUpBloc, widget);
    Padding wrapContainer = tester.firstWidget(find.byType(Padding));
    expect(wrapContainer.padding,
        const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0));

    // Look for SKIP button
    expect(
        find.ancestor(
            of: find.text('SKIP'), matching: find.byType(TextOnlyButton)),
        findsOneWidget);

    // Look for app logo
    expect(find.byWidgetPredicate((widget) {
      if (widget is! SvgPicture) {
        return false;
      }

      final SvgPicture svgPicture = widget;
      final BytesLoader bytesLoader = svgPicture.bytesLoader;

      if (bytesLoader is! SvgAssetLoader) {
        return false;
      }

      final SvgAssetLoader svgAssetLoader = bytesLoader;

      if (svgAssetLoader.assetName != Assets.images.logo) {
        return false;
      }

      return true;
    }), findsOneWidget);

    expect(
        find.ancestor(
            of: find.text('Continue with Google'),
            matching: find.byType(SecondaryButton)),
        findsOneWidget);

    expect(
        find.ancestor(
            of: find.text('Continue with Facebook'),
            matching: find.byType(SecondaryButton)),
        findsOneWidget);

    expect(
        find.ancestor(
            of: find.text('Continue with Email'),
            matching: find.byType(SecondaryButton)),
        findsOneWidget);
  });

  testWidgets('Verify button interaction', (WidgetTester widgetTester) async {
    const Widget widget = SignUpScreen();
    await widgetTester.blocWrapAndPump<SignUpBloc>(mockSignUpBloc, widget);
    // Test interaction with google Sign in
    await widgetTester
        .tap(find.widgetWithText(SecondaryButton, 'Continue with Google'));
    await widgetTester.pumpAndSettle();
    verify(mockSignUpBloc.add(const SignUpWithGoogle()));
    // Test interaction with facebook Sign in
    await widgetTester
        .tap(find.widgetWithText(SecondaryButton, 'Continue with Facebook'));
    await widgetTester.pumpAndSettle();
    verify(mockSignUpBloc.add(const SignUpWithFacebook()));
  });

  testWidgets('Skip event - detect first launch app',
      (WidgetTester tester) async {
    await tester.blocWrapAndPump<SignUpBloc>(mockSignUpBloc, widget);
    SharedPreferences.setMockInitialValues({});
    TextOnlyButton skipButton = tester.widget(find.ancestor(
        of: find.text('SKIP'), matching: find.byType(TextOnlyButton)));
    await tester.tap(find.byWidget(skipButton));
    await tester.pumpAndSettle();
    SharedPreferences pref = await SharedPreferences.getInstance();
    expect(pref.getBool(isFirstLaunchConst), false);
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

    testWidgets(
        'when state is UserRolesUnavailable, then request authentication validate',
        (widgetTester) async {
      when(authenticationBloc.state)
          .thenAnswer((realInvocation) => AuthenticationInitial());
      when(authenticationBloc.stream).thenAnswer(
          (realInvocation) => Stream.value(AuthenticationInitial()));

      when(mockSignUpBloc.state)
          .thenAnswer((realInvocation) => const UserRolesUnavailable());
      when(mockSignUpBloc.stream).thenAnswer(
          (realInvocation) => Stream.value(const UserRolesUnavailable()));

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
