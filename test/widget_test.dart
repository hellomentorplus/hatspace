// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/home/view/home_view.dart';
import 'package:hatspace/features/sign_up/view_model/sign_up_bloc.dart';
import 'package:hatspace/initial_app.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/view_models/app_config/bloc/app_config_bloc.dart';
import 'package:hatspace/view_models/authentication/authentication_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'bloc/app_confilg_bloc/app_config_bloc_test.mocks.dart';
import 'widget_test.mocks.dart';
import 'widget_tester_extension.dart';

@GenerateMocks([
  AppConfigBloc,
  SignUpBloc,
  StorageService,
  AuthenticationService,
  AuthenticationBloc
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MockFirebaseRemoteConfig mockFirebaseRemoteConfig =
      MockFirebaseRemoteConfig();
  final MockAppConfigBloc mockAppConfigBloc = MockAppConfigBloc();
  final MockSignUpBloc mockSignUpBloc = MockSignUpBloc();
  final MockAuthenticationBloc authenticationBloc = MockAuthenticationBloc();

  final MockStorageService storageService = MockStorageService();
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();

  setUpAll(() async {
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);

    when(mockFirebaseRemoteConfig.fetchAndActivate()).thenAnswer((_) {
      return Future.value(true);
    });
    when(mockFirebaseRemoteConfig.getBool('debug_option_enabled'))
        .thenReturn(true);
    when(mockAppConfigBloc.stream).thenAnswer((realInvocation) {
      // Bloc's using stream to return states
      return Stream.value(
          const DebugOptionEnabledState(debugOptionEnabled: true));
    });
    when(mockAppConfigBloc.state).thenAnswer((realInvocation) {
      return const DebugOptionEnabledState(debugOptionEnabled: true);
    });

    // SET UP SIGN UP BLOC

    when(mockSignUpBloc.stream).thenAnswer((realInvocation) {
      // Bloc's using stream to return states
      return Stream.value(const SignUpInitial());
    });
    // whenListen(mockSignUpBloc, Stream.fromIterable([const FirstLaunchScreen(true)]));
    when(mockSignUpBloc.state).thenAnswer((realInvocation) {
      return const SignUpInitial();
    });

    // SET UP FOR BLOC LISTENER

    // await FirebaseRemoteConfig.instance.ensureInitialized();
  });

  testWidgets('Check home screen title when user not login',
      (WidgetTester tester) async {
    when(authenticationBloc.state)
        .thenAnswer((realInvocation) => AnonymousState());
    when(authenticationBloc.stream)
        .thenAnswer((realInvocation) => Stream.value(AnonymousState()));

    const widget = HomePageView();
    await tester.multiBlocWrapAndPump([
      BlocProvider<AppConfigBloc>(
        create: (context) => mockAppConfigBloc,
      ),
      BlocProvider<AuthenticationBloc>(
        create: (context) => authenticationBloc,
      )
    ], widget);
    expect(find.text('Hi there 👋'), findsOneWidget);
  });

  testWidgets('Check home screen title when user login',
      (WidgetTester tester) async {
    final UserDetail userDetail =
        UserDetail(uid: 'uid', displayName: 'displayName');
    when(authenticationBloc.state)
        .thenAnswer((realInvocation) => AuthenticatedState(userDetail));
    when(authenticationBloc.stream).thenAnswer(
        (realInvocation) => Stream.value(AuthenticatedState(userDetail)));

    const widget = HomePageView();
    await tester.multiBlocWrapAndPump([
      BlocProvider<AppConfigBloc>(
        create: (context) => mockAppConfigBloc,
      ),
      BlocProvider<AuthenticationBloc>(
        create: (context) => authenticationBloc,
      )
    ], widget);
    expect(find.text('👋 Hi displayName'), findsOneWidget);
  });

  testWidgets('Check bottom app bar', (WidgetTester tester) async {
    const widget = HomePageView();
    await tester.multiBlocWrapAndPump([
      BlocProvider<AppConfigBloc>(
        create: (context) => mockAppConfigBloc,
      ),
      BlocProvider<AuthenticationBloc>(
        create: (context) => authenticationBloc,
      )
    ], widget); // Verify content of bottom app bar
    expect(find.text('Explore'), findsOneWidget);
    expect(find.text('Booking'), findsOneWidget);
    expect(find.text('Message'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('It should have a widget', (tester) async {
    const widget = MyAppBody();
    await tester.multiBlocWrapAndPump([
      BlocProvider<SignUpBloc>(
        create: (context) => mockSignUpBloc,
      ),
      BlocProvider<AppConfigBloc>(
        create: (context) => mockAppConfigBloc,
      ),
      BlocProvider<AuthenticationBloc>(
        create: (context) => authenticationBloc,
      )
    ], widget);
    final renderingWidget = tester.widget(find.byType(MyAppBody));
    expect(renderingWidget, isA<Widget>());
  });
}
