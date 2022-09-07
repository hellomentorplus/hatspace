// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hatspace/main.dart';
import 'package:hatspace/verification_screen.dart';

void main() {
  testWidgets('MyApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.wrapAndPumpWidget(const MyApp());

    // expect(find.text('Space App'), findsOneWidget);

    Text titleText = tester.widget(find.text('Space App'));

    expect(titleText.data, 'Space App');
    expect(titleText.style?.color, Colors.white);
    expect(titleText.textAlign, TextAlign.center);

    Padding outterText = tester.widget(find.ancestor(
        of: find.text('Space App'), matching: find.byType(Padding)));

    expect(outterText.padding, const EdgeInsets.only(top: 50.0));
  });

  testWidgets('VerificationScreen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.wrapAndPumpWidget(const VerificationScreen());

    // expect(find.text('Space App'), findsOneWidget);

    Text titleText = tester.widget(find.text('Space App'));

    expect(titleText.data, 'Space App');
    expect(titleText.style?.color, Colors.white);
    expect(titleText.textAlign, TextAlign.center);

    Padding outterText = tester.widget(find.ancestor(
        of: find.text('Space App'), matching: find.byType(Padding)));

    expect(outterText.padding, const EdgeInsets.only(top: 50.0));
  });
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> wrapAndPumpWidget(Widget widget) async {
    await pumpWidget(MaterialApp(
      home: widget,
    ));
    await pump();
  }
}
