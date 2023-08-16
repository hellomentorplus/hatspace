import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/sign_up/view/sign_up_screen.dart';
import 'package:hatspace/features/sign_up/view_model/apple_signin_cubit.dart';
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

import '../../../widget_tester_extension.dart';
import '../../add_property/view/widgets/add_rooms_view_test.dart';
import 'sign_up_screen_test.mocks.dart';

@GenerateMocks([
  SignUpBloc,
  AuthenticationBloc,
  StorageService,
  AuthenticationService,
  AppleSignInCubit
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final MockSignUpBloc mockSignUpBloc = MockSignUpBloc();
  final MockAuthenticationBloc authenticationBloc = MockAuthenticationBloc();
  final MockStorageService storageService = MockStorageService();
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockAppleSignInCubit appleSignInCubit = MockAppleSignInCubit();

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

    when(authenticationService.authenticationState)
        .thenAnswer((realInvocation) => const Stream.empty());
  });

  setUp(() {
    when(mockSignUpBloc.stream)
        .thenAnswer((realInvocation) => const Stream.empty());
    when(mockSignUpBloc.state)
        .thenAnswer((realInvocation) => const SignUpInitial());
    when(authenticationBloc.stream)
        .thenAnswer((realInvocation) => const Stream.empty());
    when(authenticationBloc.state)
        .thenAnswer((realInvocation) => AuthenticationInitial());
    when(appleSignInCubit.stream)
        .thenAnswer((realInvocation) => const Stream.empty());
    when(appleSignInCubit.state)
        .thenAnswer((realInvocation) => AppleSignInInitial());
  });

  tearDown(() {
    reset(storageService);
    reset(authenticationService);
    reset(mockSignUpBloc);
    reset(authenticationBloc);
  });

  testWidgets('Check skip icon button', (WidgetTester tester) async {
    const Widget widget = SignUpBody();
    await tester.multiBlocWrapAndPump([
      BlocProvider<AuthenticationBloc>(
        create: (context) => authenticationBloc,
      ),
      BlocProvider<SignUpBloc>(
        create: (context) => mockSignUpBloc,
      ),
      BlocProvider<AppleSignInCubit>(
        create: (context) => appleSignInCubit,
      ),
    ], widget);
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
        findsNothing);
  });

  testWidgets('Verify button interaction', (WidgetTester widgetTester) async {
    const Widget widget = SignUpBody();
    await widgetTester.multiBlocWrapAndPump([
      BlocProvider<AuthenticationBloc>(
        create: (context) => authenticationBloc,
      ),
      BlocProvider<SignUpBloc>(
        create: (context) => mockSignUpBloc,
      ),
      BlocProvider<AppleSignInCubit>(
        create: (context) => appleSignInCubit,
      ),
    ], widget);
    // Test interaction with google Sign in
    await widgetTester
        .tap(find.widgetWithText(SecondaryButton, 'Continue with Google'));
    await widgetTester.pumpAndSettle();
    verify(mockSignUpBloc.add(const SignUpWithGoogle())).called(1);
    // Test interaction with facebook Sign in
    await widgetTester
        .tap(find.widgetWithText(SecondaryButton, 'Continue with Facebook'));
    await widgetTester.pumpAndSettle();
    verify(mockSignUpBloc.add(const SignUpWithFacebook()));
  });

  testWidgets('Skip event - detect first launch app',
      (WidgetTester tester) async {
    const Widget widget = SignUpBody();
    await tester.multiBlocWrapAndPump([
      BlocProvider<SignUpBloc>(
        create: (context) => mockSignUpBloc,
      ),
      BlocProvider<AuthenticationBloc>(
        create: (context) => authenticationBloc,
      ),
      BlocProvider<AppleSignInCubit>(
        create: (context) => appleSignInCubit,
      ),
    ], widget);

    SharedPreferences.setMockInitialValues({});
    TextOnlyButton skipButton = tester.widget(find.ancestor(
        of: find.text('SKIP'), matching: find.byType(TextOnlyButton)));
    await tester.tap(find.byWidget(skipButton));
    await tester.pumpAndSettle();

    verify(authenticationBloc.add(SkipSignUp())).called(1);
  });

  testWidgets('Skip event - on Android back button',
          (WidgetTester tester) async {
        const Widget widget = SignUpBody();
        await tester.multiBlocWrapAndPump([
          BlocProvider<SignUpBloc>(
            create: (context) => mockSignUpBloc,
          ),
          BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc,
          ),
          BlocProvider<AppleSignInCubit>(
            create: (context) => appleSignInCubit,
          ),
        ], widget);

        SharedPreferences.setMockInitialValues({});

        // imitate Android back button
        final dynamic widgetsAppState = tester.state(find.byType(WidgetsApp));
        // need to use dynamic here, because _WidgetsAppState is private
        // ignore: avoid_dynamic_calls
        await widgetsAppState.didPopRoute();

        verify(authenticationBloc.add(SkipSignUp())).called(1);
      });

  group('verify listener events', () {
    tearDown(() {
      reset(mockSignUpBloc);
      reset(authenticationBloc);
    });

    setUp(() {
      when(authenticationService.authenticationState)
          .thenAnswer((realInvocation) => const Stream.empty());
    });

    testWidgets('when state is SignUpStart, then show loading screen',
        (widgetTester) async {
      when(mockSignUpBloc.state).thenAnswer((realInvocation) => SignUpStart());
      when(mockSignUpBloc.stream)
          .thenAnswer((realInvocation) => Stream.value(SignUpStart()));

      const Widget widget = SignUpBody();

      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<SignUpBloc>(
          create: (context) => mockSignUpBloc,
        ),
        BlocProvider<AppleSignInCubit>(
          create: (context) => appleSignInCubit,
        ),
      ], widget, infiniteAnimationWidget: true);

      expect(find.text('Loading...'), findsOneWidget);
    });

    testWidgets('when state is UserCancelled, then show toast message',
        (widgetTester) async {
      when(mockSignUpBloc.state)
          .thenAnswer((realInvocation) => UserCancelled());
      when(mockSignUpBloc.stream)
          .thenAnswer((realInvocation) => Stream.value(UserCancelled()));

      const Widget widget = SignUpBody();

      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<SignUpBloc>(
          create: (context) => mockSignUpBloc,
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<AppleSignInCubit>(
          create: (context) => appleSignInCubit,
        ),
      ], widget, infiniteAnimationWidget: true);

      await widgetTester.pump(const Duration(seconds: 1));

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

      const Widget widget = SignUpBody();

      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<SignUpBloc>(
          create: (context) => mockSignUpBloc,
        ),
        BlocProvider<AppleSignInCubit>(
          create: (context) => appleSignInCubit,
        ),
      ], widget, infiniteAnimationWidget: true);

      await widgetTester.pump(const Duration(seconds: 1));

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

      const Widget widget = SignUpBody();

      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<SignUpBloc>(
          create: (context) => mockSignUpBloc,
        ),
        BlocProvider<AppleSignInCubit>(
          create: (context) => appleSignInCubit,
        ),
      ], widget, infiniteAnimationWidget: true, useRouter: true);

      // expect to dismiss this view
      expect(find.byType(SignUpBody), findsNothing);
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

      const Widget widget = SignUpBody();

      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
        ),
        BlocProvider<SignUpBloc>(
          create: (context) => mockSignUpBloc,
        ),
        BlocProvider<AppleSignInCubit>(
          create: (context) => appleSignInCubit,
        ),
      ], widget, infiniteAnimationWidget: true, useRouter: true);

      // expect to not see this screen anymore
      expect(find.byType(SignUpBody), findsNothing);
    });
  });

  testWidgets(
      'given state is AppleSignInAvailable, '
      'when launching SignUp screen, '
      'then Apple signup button will be shown', (WidgetTester tester) async {
    const Widget widget = SignUpBody();

    when(appleSignInCubit.state)
        .thenAnswer((realInvocation) => AppleSignInAvailable());

    await tester.multiBlocWrapAndPump([
      BlocProvider<AuthenticationBloc>(
        create: (context) => authenticationBloc,
      ),
      BlocProvider<SignUpBloc>(
        create: (context) => mockSignUpBloc,
      ),
      BlocProvider<AppleSignInCubit>(
        create: (context) => appleSignInCubit,
      ),
    ], widget);

    expect(find.text('Continue with Apple'), findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(widget, 'assets/icons/apple.svg')),
        findsOneWidget);
  });
}
