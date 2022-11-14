import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/theme/hs_theme.dart';

import '../widget_tester_extension.dart';

void main() {
  testWidgets('Validate [TITLE] text style ', (WidgetTester tester) async {
    GlobalKey largeK = GlobalKey();

    final Builder displayTextGroup = Builder(builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              'Text Large',
              key: largeK,
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ),
      );
    });

    await tester.wrapAndPump(displayTextGroup, theme: lightThemeData);

    final Text renderedLargeT = tester.widget<Text>(find.byKey(largeK));

    expect(renderedLargeT.style?.fontWeight, FontStyleGuide.fwRegular);
    expect(renderedLargeT.style?.fontSize, FontStyleGuide.fontSize34);
    expect(
        renderedLargeT.style?.letterSpacing, FontStyleGuide.letterSpacing025);
    expect(renderedLargeT.style?.height, FontStyleGuide.height);
  });

  testWidgets('Validate [HEADLINE] text style ', (WidgetTester tester) async {
    GlobalKey largeK = GlobalKey();
    GlobalKey mediumK = GlobalKey();

    final Builder displayTextGroup = Builder(builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Test Large',
                key: largeK, style: Theme.of(context).textTheme.displayLarge),
            Text('Test Medium',
                key: mediumK, style: Theme.of(context).textTheme.displayMedium)
          ],
        ),
      );
    });

    await tester.wrapAndPump(displayTextGroup, theme: lightThemeData);

    final Text renderedLargeT = tester.widget<Text>(find.byKey(largeK));
    final Text renderedMediumT = tester.widget<Text>(find.byKey(mediumK));

    expect(renderedLargeT.style?.fontSize, FontStyleGuide.fontSize26);
    expect(renderedLargeT.style?.fontWeight, FontStyleGuide.fwRegular);
    expect(renderedLargeT.style?.letterSpacing, FontStyleGuide.letterSpacing0);
    expect(renderedLargeT.style?.height, FontStyleGuide.height);

    expect(renderedMediumT.style?.fontSize, FontStyleGuide.fontSize26);
    expect(renderedMediumT.style?.fontWeight, FontStyleGuide.fwRegular);
    expect(renderedMediumT.style?.letterSpacing, FontStyleGuide.letterSpacing0);
    expect(renderedMediumT.style?.height, FontStyleGuide.height);
  });

  testWidgets('Validate [SUBTITLE] text style ', (WidgetTester tester) async {
    GlobalKey mediumK = GlobalKey();

    final Builder displayTextGroup = Builder(builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Test Medium',
                key: mediumK, style: Theme.of(context).textTheme.titleMedium)
          ],
        ),
      );
    });

    await tester.wrapAndPump(displayTextGroup, theme: lightThemeData);

    final Text renderedMediumT = tester.widget<Text>(find.byKey(mediumK));

    expect(renderedMediumT.style?.fontSize, FontStyleGuide.fontSize17);
    expect(renderedMediumT.style?.fontWeight, FontStyleGuide.fwSemibold);
    expect(
        renderedMediumT.style?.letterSpacing, FontStyleGuide.letterSpacing015);
    expect(renderedMediumT.style?.height, FontStyleGuide.height);
  });

  testWidgets('Validate [BODY] text style ', (WidgetTester tester) async {
    GlobalKey largeK = GlobalKey();
    GlobalKey mediumK = GlobalKey();

    final Builder displayTextGroup = Builder(builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Test Large',
                key: largeK, style: Theme.of(context).textTheme.bodyLarge),
            Text('Test Medium',
                key: mediumK, style: Theme.of(context).textTheme.bodyMedium)
          ],
        ),
      );
    });

    await tester.wrapAndPump(displayTextGroup, theme: lightThemeData);

    final Text renderedLargeT = tester.widget<Text>(find.byKey(largeK));
    final Text renderedMediumT = tester.widget<Text>(find.byKey(mediumK));

    expect(renderedLargeT.style?.fontSize, FontStyleGuide.fontSize17);
    expect(renderedLargeT.style?.fontWeight, FontStyleGuide.fwRegular);
    expect(renderedLargeT.style?.letterSpacing, FontStyleGuide.letterSpacing05);
    expect(renderedLargeT.style?.height, FontStyleGuide.height);

    expect(renderedMediumT.style?.fontSize, FontStyleGuide.fontSize13);
    expect(renderedMediumT.style?.fontWeight, FontStyleGuide.fwRegular);
    expect(
        renderedMediumT.style?.letterSpacing, FontStyleGuide.letterSpacing04);
    expect(renderedMediumT.style?.height, FontStyleGuide.height);
  });

  testWidgets('Validate [BUTTON] text style ', (WidgetTester tester) async {
    GlobalKey largeK = GlobalKey();

    final Builder displayTextGroup = Builder(builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Test Large',
                key: largeK, style: Theme.of(context).textTheme.labelLarge)
          ],
        ),
      );
    });

    await tester.wrapAndPump(displayTextGroup, theme: lightThemeData);

    final Text renderedLargeT = tester.widget<Text>(find.byKey(largeK));

    expect(renderedLargeT.style?.fontSize, FontStyleGuide.fontSize13);
    expect(renderedLargeT.style?.fontWeight, FontStyleGuide.fwRegular);
    expect(renderedLargeT.style?.letterSpacing, FontStyleGuide.letterSpacing04);
    expect(renderedLargeT.style?.height, FontStyleGuide.height);
  });

  testWidgets('Validate [CAPTION] text style ', (WidgetTester tester) async {
    GlobalKey smallK = GlobalKey();

    final Builder displayTextGroup = Builder(builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Test Small',
                key: smallK, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      );
    });

    await tester.wrapAndPump(displayTextGroup, theme: lightThemeData);

    final Text renderedSmallT = tester.widget<Text>(find.byKey(smallK));

    expect(renderedSmallT.style?.fontSize, FontStyleGuide.fontSize12);
    expect(renderedSmallT.style?.fontWeight, FontStyleGuide.fwRegular);
    expect(renderedSmallT.style?.letterSpacing, FontStyleGuide.letterSpacing04);
    expect(renderedSmallT.style?.height, FontStyleGuide.height);
  });

  testWidgets('Validate [OVERLINE] text style ', (WidgetTester tester) async {
    GlobalKey smallK = GlobalKey();

    final Builder displayTextGroup = Builder(builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Test Small',
                key: smallK, style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
      );
    });

    await tester.wrapAndPump(displayTextGroup, theme: lightThemeData);

    final Text renderedSmallT = tester.widget<Text>(find.byKey(smallK));

    expect(renderedSmallT.style?.fontSize, FontStyleGuide.fontSize10);
    expect(renderedSmallT.style?.fontWeight, FontStyleGuide.fwRegular);
    expect(renderedSmallT.style?.letterSpacing, FontStyleGuide.letterSpacing15);
    expect(renderedSmallT.style?.height, FontStyleGuide.height);
  });
}

// class _materialWrapWidget extends StatelessWidget {
//   final Widget child;
//   final ThemeData? theme;

//   const _materialWrapWidget({required this.child, Key? key, this.theme})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         theme: themeData,
//         home: Scaffold(
//           body: child,
//         ),
//       );
// }
