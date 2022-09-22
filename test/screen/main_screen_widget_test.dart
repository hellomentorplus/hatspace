import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/main.dart';

void main() {
  testWidgets('titleText smoke test', (WidgetTester tester) async {
    await tester.wrapAndPumpWidget(HomePage());

    Text titleText = tester.widget(find.text('Space App'));

    expect(titleText.data, 'Space App');
    expect(titleText.style?.color, Colors.white);
    expect(titleText.textAlign, TextAlign.center);
  });

  testWidgets('outterText smoke test', (WidgetTester tester) async {
    await tester.wrapAndPumpWidget(HomePage());

    Padding outterText = tester.widget(find.ancestor(
        of: find.text('Space App'), matching: find.byType(Padding)));

    expect(outterText.padding, const EdgeInsets.only(top: 50.0));
  });

  testWidgets('mainColumn smoke test', (WidgetTester tester) async {
    await tester.wrapAndPumpWidget(HomePage());

    Padding outterText = tester.widget(find.ancestor(
        of: find.text('Space App'), matching: find.byType(Padding)));

    Column mainColumn = tester.widget(find.ancestor(
        of: find.byWidget(outterText), matching: find.byType(Column)));
    expect(mainColumn.crossAxisAlignment, CrossAxisAlignment.stretch);
  });

  testWidgets('textButton1 smoke test', (WidgetTester tester) async {
    await tester.wrapAndPumpWidget(HomePage());

    TextButton textButton1 = tester.widget(find.ancestor(
        of: find.text('Continue'), matching: find.byType(TextButton)));

    // expect(textButton1.onPressed(), );
  });
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> wrapAndPumpWidget(Widget widget) async {
    await pumpWidget(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white))),
      ),
      home: widget,
    ));
    await pump();
  }
}
