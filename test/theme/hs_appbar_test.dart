import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/theme/widgets/hs_appbar.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

import '../widget_tester_extension.dart';

void main() {
  testWidgets('Verify AppBar UI', (WidgetTester tester) async {
    int counter = 0;
    Widget widget = Scaffold(
      appBar: HsAppBar(
        title: 'This is title',
        actions: [
          IconButton(onPressed: () => counter += 1, icon: const Text('Plus')),
          IconButton(onPressed: () => counter -= 1, icon: const Text('Minus')),
        ],
      ),
    );
    await tester.wrapAndPump(widget);

    final Finder backBtnFinder = find.byType(HsBackButton);
    expect(backBtnFinder, findsOneWidget);

    final Finder titleFinder = find.text('This is title');
    expect(titleFinder, findsOneWidget);
    final Text titleWidget = tester.widget(titleFinder);
    expect(titleWidget.style?.fontSize, 14);
    expect(titleWidget.style?.fontWeight, FontWeight.w700);

    final Finder plusBtn =
        find.ancestor(of: find.text('Plus'), matching: find.byType(IconButton));
    expect(plusBtn, findsOneWidget);

    final Finder minusBtn = find.ancestor(
        of: find.text('Minus'), matching: find.byType(IconButton));
    expect(minusBtn, findsOneWidget);
  });

  testWidgets('Verify AppBar interactions', (WidgetTester tester) async {
    int counter = 0;
    Widget widget = Scaffold(
      appBar: HsAppBar(
        title: 'This is title',
        actions: [
          IconButton(onPressed: () => counter += 1, icon: const Text('Plus')),
          IconButton(onPressed: () => counter -= 1, icon: const Text('Minus')),
        ],
      ),
    );
    await tester.wrapAndPump(widget);

    final Finder backBtnFinder = find.byType(HsBackButton);
    expect(backBtnFinder, findsOneWidget);

    final Finder plusBtn =
        find.ancestor(of: find.text('Plus'), matching: find.byType(IconButton));
    expect(plusBtn, findsOneWidget);

    final Finder minusBtn = find.ancestor(
        of: find.text('Minus'), matching: find.byType(IconButton));
    expect(minusBtn, findsOneWidget);

    await tester.tap(plusBtn);
    await tester.pumpAndSettle();

    expect(counter, 1);

    await tester.tap(minusBtn);
    await tester.pumpAndSettle();
    expect(counter, 0);

    await tester.tap(backBtnFinder);
    await tester.pumpAndSettle();
    expect(find.text('This is title'), findsNothing);
    expect(find.byType(IconButton), findsNothing);
  });
}
