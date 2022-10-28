// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/home/view/home_view.dart';

import 'package:hatspace/main.dart';

import 'widget_tester_extension.dart';

void main() {
  testWidgets('Check home screen title', (WidgetTester tester) async {
    const widget = HomePageView();
    await tester.wrapAndPump(widget);

    // // Verify that our counter starts at 0.
    expect(find.text('HAT Space'), findsOneWidget);
  });
}
