// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/home/view/home_view.dart';
import 'package:hatspace/features/sign_up/view/sign_up_view.dart';

import 'package:hatspace/initial_app.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/view_models/app_config_bloc.dart';

import 'firebase_core_mock.dart';
import 'widget_tester_extension.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Check home screen title', (WidgetTester tester) async {
    final widget = HomePageView();

    await tester.blocWrapAndPump(AppConfigBloc(), widget);

    // // Verify that our counter starts at 0.
    expect(find.text('HAT Space'), findsOneWidget);
  });

  testWidgets('Check button navigation bar', (WidgetTester tester) async {
    final widget = HomePageView();
    await tester.blocWrapAndPump(AppConfigBloc(),widget);

    // // Verify that our counter starts at 0.
    expect(find.text('Explore'), findsOneWidget);
    expect(find.text('Tracking'), findsOneWidget);
    expect(find.text('Inbox'), findsOneWidget);
  });
  setupFirebaseAuthMocks();
    setUpAll(() async {
    await Firebase.initializeApp();
    // await FirebaseRemoteConfig.instance.ensureInitialized();
  });
  testWidgets('It should have a widget', (tester) async {
    final widget = MyApp();
    await tester.blocWrapAndPump(AppConfigBloc(), widget, theme: lightThemeData);
    final renderingWidget = tester.widget(find.byType(HomePageView));
    expect(renderingWidget, isA<Widget>());
  });
}
