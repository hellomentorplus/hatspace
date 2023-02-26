// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/home/view/home_view.dart';
import 'package:hatspace/features/sign_up/view_model/sign_up_bloc.dart';
import 'package:hatspace/initial_app.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/view_models/app_config/app_config_bloc.dart';
import 'package:hatspace/view_models/app_config/app_config_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'bloc/app_config_bloc_test.mocks.dart';
import 'firebase_core_mock.dart';
import 'widget_test.mocks.dart';
import 'widget_tester_extension.dart';

@GenerateMocks([AppConfigBloc, SignUpBloc])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  MockFirebaseRemoteConfig mockFirebaseRemoteConfig =
      MockFirebaseRemoteConfig();
  MockAppConfigBloc mockAppConfigBloc = MockAppConfigBloc();
  MockSignUpBloc mockSignUpBloc = MockSignUpBloc();
  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
    when(mockFirebaseRemoteConfig.fetchAndActivate()).thenAnswer((_) {
      return Future.value(true);
    });
    when(mockFirebaseRemoteConfig.getBool("debug_option_enabled"))
        .thenReturn(true);
    when(mockAppConfigBloc.stream).thenAnswer((realInvocation) {
      // Bloc's using stream to return states
      return Stream.value(DebugOptionEnabledState(debugOptionEnabled: true));
    });
    when(mockAppConfigBloc.state).thenAnswer((realInvocation) {
      return DebugOptionEnabledState(debugOptionEnabled: true);
    });

    // SET UP SIGN UP BLOC

    when(mockSignUpBloc.stream).thenAnswer((realInvocation) {
      // Bloc's using stream to return states
      return Stream.value(FirstLaunchScreen(true));
    });
    when(mockSignUpBloc.state).thenAnswer((realInvocation) {
      return FirstLaunchScreen(true);
    });

    // await FirebaseRemoteConfig.instance.ensureInitialized();
  });
  testWidgets('Check home screen title', (WidgetTester tester) async {
    final widget = HomePageView();
    await tester.blocWrapAndPump<AppConfigBloc>(mockAppConfigBloc, widget);

    // // Verify that our counter starts at 0.
    expect(find.text('HAT Space'), findsOneWidget);
  });

  testWidgets('Check button navigation bar', (WidgetTester tester) async {
    final widget = HomePageView();
    await tester.blocWrapAndPump<AppConfigBloc>(mockAppConfigBloc, widget);

    // // Verify that our counter starts at 0.
    expect(find.text('Explore'), findsOneWidget);
    expect(find.text('Tracking'), findsOneWidget);
    expect(find.text('Inbox'), findsOneWidget);
  });

  testWidgets('It should have a widget', (tester) async {
    const widget = MyAppBody();
    await tester.blocWrapAndPump<SignUpBloc>(mockSignUpBloc, widget);
    final renderingWidget = tester.widget(find.byType(MyAppBody));
    expect(renderingWidget, isA<Widget>());
  });
}
