// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/Screen/HomeScreen.dart';
import 'package:hatspace/Screen/VerificationScreen.dart';

import 'package:hatspace/main.dart';

import 'widget_test/homescreen_test.dart';
import 'widget_test/verificationscreen_test.dart';

void main() {
  homeScreenTest();
  verificationScreenTest();
}

// Declare new Extension
extension WidgetTesterExtension on WidgetTester {
  Future<void> wrapAndPumpWidget(Widget widget) async {
    await pumpWidget(MaterialApp(
      home: widget,
    ));
    await pump();
  }
}
