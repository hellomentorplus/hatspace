import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/theme/hs_theme.dart';

import '../widget_tester_extension.dart';

void main() {
  testWidgets('Validate [TITLE] text style ', (WidgetTester tester) async {
    GlobalKey largeK = GlobalKey();

    final Builder displayTextGroup = Builder(builder: (BuildContext context) {
      return Center(
          child: Text(
        'Text Large',
        key: largeK,
        style: Theme.of(context).textTheme.titleLarge,
      ));
    });

    await tester.wrapAndPump(displayTextGroup, theme: lightThemeData);

    final Text renderedLargeT = tester.widget<Text>(find.byKey(largeK));

    expect(renderedLargeT.style?.fontWeight, FontStyleGuide.fwRegular);
    expect(renderedLargeT.style?.fontSize, FontStyleGuide.fontSize34);
    expect(
        renderedLargeT.style?.letterSpacing, FontStyleGuide.letterSpacing025);
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

    expect(renderedMediumT.style?.fontSize, FontStyleGuide.fontSize26);
    expect(renderedMediumT.style?.fontWeight, FontStyleGuide.fwRegular);
    expect(renderedMediumT.style?.letterSpacing, FontStyleGuide.letterSpacing0);
  });

  testWidgets('Validate [SUBTITLE] text style ', (WidgetTester tester) async {
    GlobalKey mediumK = GlobalKey();

    final Builder displayTextGroup = Builder(builder: (BuildContext context) {
      return Center(
          child: Text('Test Medium',
              key: mediumK, style: Theme.of(context).textTheme.titleMedium));
    });

    await tester.wrapAndPump(displayTextGroup, theme: lightThemeData);

    final Text renderedMediumT = tester.widget<Text>(find.byKey(mediumK));

    expect(renderedMediumT.style?.fontSize, FontStyleGuide.fontSize17);
    expect(renderedMediumT.style?.fontWeight, FontStyleGuide.fwSemibold);
    expect(
        renderedMediumT.style?.letterSpacing, FontStyleGuide.letterSpacing015);
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

    expect(renderedMediumT.style?.fontSize, FontStyleGuide.fontSize14);
    expect(renderedMediumT.style?.fontWeight, FontStyleGuide.fwRegular);
    expect(
        renderedMediumT.style?.letterSpacing, FontStyleGuide.letterSpacing04);
  });

  testWidgets('Validate [BUTTON] text style ', (WidgetTester tester) async {
    GlobalKey largeK = GlobalKey();

    final Builder displayTextGroup = Builder(builder: (BuildContext context) {
      return Center(
          child: Text('Test Large',
              key: largeK, style: Theme.of(context).textTheme.labelLarge));
    });

    await tester.wrapAndPump(displayTextGroup, theme: lightThemeData);

    final Text renderedLargeT = tester.widget<Text>(find.byKey(largeK));

    expect(renderedLargeT.style?.fontSize, FontStyleGuide.fontSize13);
    expect(renderedLargeT.style?.fontWeight, FontStyleGuide.fwRegular);
    expect(renderedLargeT.style?.letterSpacing, FontStyleGuide.letterSpacing04);
  });

  testWidgets('Validate [CAPTION] text style ', (WidgetTester tester) async {
    GlobalKey smallK = GlobalKey();

    final Builder displayTextGroup = Builder(builder: (BuildContext context) {
      return Center(
        child: Text('Test Small',
            key: smallK, style: Theme.of(context).textTheme.bodySmall),
      );
    });

    await tester.wrapAndPump(displayTextGroup, theme: lightThemeData);

    final Text renderedSmallT = tester.widget<Text>(find.byKey(smallK));

    expect(renderedSmallT.style?.fontSize, FontStyleGuide.fontSize12);
    expect(renderedSmallT.style?.fontWeight, FontStyleGuide.fwRegular);
    expect(renderedSmallT.style?.letterSpacing, FontStyleGuide.letterSpacing04);
  });

  testWidgets('Validate [OVERLINE] text style ', (WidgetTester tester) async {
    GlobalKey smallK = GlobalKey();

    final Builder displayTextGroup = Builder(builder: (BuildContext context) {
      return Center(
        child: Text('Test Small',
            key: smallK, style: Theme.of(context).textTheme.labelSmall),
      );
    });

    await tester.wrapAndPump(displayTextGroup, theme: lightThemeData);

    final Text renderedSmallT = tester.widget<Text>(find.byKey(smallK));

    expect(renderedSmallT.style?.fontSize, FontStyleGuide.fontSize10);
    expect(renderedSmallT.style?.fontWeight, FontStyleGuide.fwRegular);
    expect(renderedSmallT.style?.letterSpacing, FontStyleGuide.letterSpacing15);
  });
}
