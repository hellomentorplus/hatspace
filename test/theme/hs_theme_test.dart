import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hatspace/theme/hs_theme.dart';

import '../widget_tester_extension.dart';

void main() {
  testWidgets('Validate primary theme color', (WidgetTester tester) async {
    final Builder testWidget = Builder(builder: (BuildContext context) {
      return Icon(
        Icons.abc_outlined,
        color: Theme.of(context).colorScheme.primary,
      );
    });

    await tester.wrapAndPump(testWidget, theme: lightThemeData);

    final Icon renderedIcon = tester.widget<Icon>(find.byType(Icon));

    expect(renderedIcon.color, const Color(0xFF32A854));
  });

  testWidgets('Validate onPrimary theme color', (WidgetTester tester) async {
    final Builder testWidget = Builder(builder: (BuildContext context) {
      return Icon(
        Icons.abc_outlined,
        color: Theme.of(context).colorScheme.onPrimary,
      );
    });

    await tester.wrapAndPump(testWidget, theme: lightThemeData);

    final Icon renderedIcon = tester.widget<Icon>(find.byType(Icon));

    expect(renderedIcon.color, const Color(0xFFFFFFFF));
  });

  testWidgets('Validate secondary theme color', (WidgetTester tester) async {
    final Builder testWidget = Builder(builder: (BuildContext context) {
      return Icon(
        Icons.abc_outlined,
        color: Theme.of(context).colorScheme.secondary,
      );
    });

    await tester.wrapAndPump(testWidget, theme: lightThemeData);

    final Icon renderedIcon = tester.widget<Icon>(find.byType(Icon));

    expect(renderedIcon.color, const Color(0xFFFA612B));
  });

  testWidgets('Validate onSecondary theme color', (WidgetTester tester) async {
    final Builder testWidget = Builder(builder: (BuildContext context) {
      return Icon(
        Icons.abc_outlined,
        color: Theme.of(context).colorScheme.onSecondary,
      );
    });

    await tester.wrapAndPump(testWidget, theme: lightThemeData);

    final Icon renderedIcon = tester.widget<Icon>(find.byType(Icon));

    expect(renderedIcon.color, const Color(0xFFF5F8F0));
  });

  testWidgets('Validate error theme color', (WidgetTester tester) async {
    final Builder testWidget = Builder(builder: (BuildContext context) {
      return Icon(
        Icons.abc_outlined,
        color: Theme.of(context).colorScheme.error,
      );
    });

    await tester.wrapAndPump(testWidget, theme: lightThemeData);

    final Icon renderedIcon = tester.widget<Icon>(find.byType(Icon));

    expect(renderedIcon.color, const Color(0xFFFF3B30));
  });

  testWidgets('Validate background theme color', (WidgetTester tester) async {
    final Builder testWidget = Builder(builder: (BuildContext context) {
      return Icon(
        Icons.abc_outlined,
        color: Theme.of(context).colorScheme.background,
      );
    });

    await tester.wrapAndPump(testWidget, theme: lightThemeData);

    final Icon renderedIcon = tester.widget<Icon>(find.byType(Icon));

    expect(renderedIcon.color, const Color(0xFFF8F8F8));
  });

  testWidgets('Validate onBackground theme color', (WidgetTester tester) async {
    final Builder testWidget = Builder(builder: (BuildContext context) {
      return Icon(
        Icons.abc_outlined,
        color: Theme.of(context).colorScheme.onBackground,
      );
    });

    await tester.wrapAndPump(testWidget, theme: lightThemeData);

    final Icon renderedIcon = tester.widget<Icon>(find.byType(Icon));

    expect(renderedIcon.color, const Color(0xFF282828));
  });

  testWidgets('Validate surface theme color', (WidgetTester tester) async {
    final Builder testWidget = Builder(builder: (BuildContext context) {
      return Icon(
        Icons.abc_outlined,
        color: Theme.of(context).colorScheme.surface,
      );
    });

    await tester.wrapAndPump(testWidget, theme: lightThemeData);

    final Icon renderedIcon = tester.widget<Icon>(find.byType(Icon));

    expect(renderedIcon.color, const Color(0xFFFFFFFF));
  });
}
