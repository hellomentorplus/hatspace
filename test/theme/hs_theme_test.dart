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

    final Widget wrapper = _materialWrapWidget(
      theme: themeData,
      child: testWidget,
    );

    await tester.wrapAndPump(wrapper);

    final Icon renderedIcon = tester.widget<Icon>(find.byType(Icon));

    expect(renderedIcon.color, const Color(0xFF3ACD64));
  });

  testWidgets('Validate onPrimary theme color', (WidgetTester tester) async {
    final Builder testWidget = Builder(builder: (BuildContext context) {
      return Icon(
        Icons.abc_outlined,
        color: Theme.of(context).colorScheme.onPrimary,
      );
    });

    final Widget wrapper = _materialWrapWidget(
      theme: themeData,
      child: testWidget,
    );

    await tester.wrapAndPump(wrapper);

    final Icon renderedIcon = tester.widget<Icon>(find.byType(Icon));

    expect(renderedIcon.color, const Color(0xFFF5F8F0));
  });

  testWidgets('Validate secondary theme color', (WidgetTester tester) async {
    final Builder testWidget = Builder(builder: (BuildContext context) {
      return Icon(
        Icons.abc_outlined,
        color: Theme.of(context).colorScheme.secondary,
      );
    });

    final Widget wrapper = _materialWrapWidget(
      theme: themeData,
      child: testWidget,
    );

    await tester.wrapAndPump(wrapper);

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

    final Widget wrapper = _materialWrapWidget(
      theme: themeData,
      child: testWidget,
    );

    await tester.wrapAndPump(wrapper);

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

    final Widget wrapper = _materialWrapWidget(
      theme: themeData,
      child: testWidget,
    );

    await tester.wrapAndPump(wrapper);

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

    final Widget wrapper = _materialWrapWidget(
      theme: themeData,
      child: testWidget,
    );

    await tester.wrapAndPump(wrapper);

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

    final Widget wrapper = _materialWrapWidget(
      theme: themeData,
      child: testWidget,
    );

    await tester.wrapAndPump(wrapper);

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

    final Widget wrapper = _materialWrapWidget(
      theme: themeData,
      child: testWidget,
    );

    await tester.wrapAndPump(wrapper);

    final Icon renderedIcon = tester.widget<Icon>(find.byType(Icon));

    expect(renderedIcon.color, const Color(0xFFFFFFFF));
  });
}

class _materialWrapWidget extends StatelessWidget {
  final Widget child;
  final ThemeData? theme;

  const _materialWrapWidget({required this.child, Key? key, this.theme})
      : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: themeData,
        home: Scaffold(
          body: child,
        ),
      );
}
