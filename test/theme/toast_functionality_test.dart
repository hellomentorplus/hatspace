import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/theme/toast_messages/hs_toast_theme.dart';
import 'package:hatspace/theme/toast_messages/toast_messages_extension.dart';

import '../widget_tester_extension.dart';

void main() {
  testWidgets('Test show toast and close toast function',
      ((WidgetTester test) async {
    Widget testWidget = Builder(builder: (context) {
      return Center(
          child: ElevatedButton(
        key: const Key('tap-show-toast'),
        onPressed: () {
          context.showToast(
              type: ToastType.errorToast,
              title: 'test title',
              message: 'message');
        },
        child: const Text('show toast'),
      ));
    });

    await test.wrapAndPump(testWidget);
    // First: Ensure no toast rendered
    expect(find.text('test title'), findsNothing);
    await test.tap(find.byKey(const Key('tap-show-toast')));
    // Even after tap, toast has not been displayed at this time
    expect(find.text('test title'), findsNothing);
    await test
        .pump(); // schedule animation => Toast should be shown after this time
    await test.pump(const Duration(milliseconds: 750));
    expect(find.text('test title'), findsOneWidget);
    // Second: Toast should dismiss after 6 seconds
    await test.pump(const Duration(seconds: 6));
    expect(find.text('test title'), findsNothing);

    // Cover close toast function
    // Show toast process is the same as the one above
    expect(find.text('test title'), findsNothing);
    await test.tap(find.byKey(const Key('tap-show-toast')));
    expect(find.text('test title'), findsNothing);
    await test.pump(); // schedule animation
    await test.pump(const Duration(milliseconds: 750));
    expect(find.text('test title'), findsOneWidget);
    // Toast should be shown now then action to close toast
    await test.tap(find.byKey(const Key('closeTap')));
    // after closeTap get tapped => widget should not be shown now
    await test.pump();
    expect(find.text('test title'), findsNothing);
    await test.pump(const Duration(seconds: 6));
    expect(find.text('test title'), findsNothing);
  }));

  testWidgets('Test show toast once for multiple toast message',
      (WidgetTester test) async {
    Widget testWidget = Builder(builder: (context) {
      return Center(
          child: ElevatedButton(
        key: const Key('tap-show-toast'),
        onPressed: () {
          context.showToast(
              type: ToastType.errorToast,
              title: 'test title',
              message: 'message');
        },
        child: const Text('show toast'),
      ));
    });
    await test.wrapAndPump(testWidget);
    await test.tap(find.byKey(const Key('tap-show-toast')));
    await test.pump();
    await test.pump(const Duration(milliseconds: 750));
    expect(find.text('test title'), findsOneWidget);

    // tap to show toast again
    await test.tap(find.byKey(const Key('tap-show-toast')));
    await test.pump();
    await test.pump(const Duration(milliseconds: 750));
    // still only 1 toast message
    expect(find.text('test title'), findsOneWidget);

    // allow time to let timer be cancelled by itself
    await test.pump(const Duration(seconds: 7));
    // ensure no more toast message
    expect(find.text('test title'), findsNothing);
  });
}
