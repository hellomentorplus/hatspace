import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/Screen/HomeScreen.dart';


void main() {
  testWidgets('Home Screen - main outtr column', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.wrapAndPumpWidget(MyHomePage());
    Iterable<Column> parentCol = tester.widgetList(find.byType(Column));
    expect(parentCol.first.mainAxisAlignment, MainAxisAlignment.spaceAround);
    expect(parentCol.first.crossAxisAlignment, CrossAxisAlignment.stretch);
  });
  testWidgets('Home Screen - header', (WidgetTester tester) async {
    await tester.wrapAndPumpWidget(MyHomePage());
    // Getting the widget
    Text headerText = tester.widget(find.text("Space App"));
    expect(headerText.style?.color, Colors.white);
    expect(headerText.style?.fontSize, 16);
    expect(headerText.textAlign, TextAlign.center);
    expect(headerText.style?.fontWeight, FontWeight.w800);
  });

  testWidgets('Home Screen-space button group', (WidgetTester tester) async {
    await tester.wrapAndPumpWidget(MyHomePage());
    Text headerText = tester.widget(find.text("Space"));
    expect(headerText.style?.color, Colors.white);
    expect(headerText.style?.fontWeight,FontWeight.bold);

    Iterable<Container> containerList =
        tester.widgetList(find.byType(Container));
    //============
    expect(containerList.elementAt(1).padding,
    const EdgeInsets.fromLTRB(0, 10, 0, 10));
    Text text = tester.widget(find.text("Please enter your email address"));
    expect(text.style?.color, Colors.white);
    expect(text.style?.fontWeight, FontWeight.w800);

    //=============
    expect(containerList.elementAt(2).padding,
        const EdgeInsets.fromLTRB(30, 20, 30, 20));
    expect(containerList.elementAt(2).child, isA<TextField>());
    TextField textField = tester.widget(find.byType(TextField));
    TextStyle? textFieldStyle = textField.style;
    expect(textFieldStyle?.color, Colors.white);
    expect(textField.style?.fontWeight, FontWeight.w800);

    // Test Text Filed Decoration
    // Test border-padding-foucesBorder-hintText
    InputDecoration? textFieldDecoration = textField.decoration;
    expect(textFieldDecoration?.contentPadding, const EdgeInsets.all(10));
    expect(textFieldDecoration?.filled, true);
    expect(textFieldDecoration?.hintText, "Email address");
    InputBorder? textFiledBorder = textFieldDecoration?.enabledBorder;
    expect(textFiledBorder?.borderSide,
        const BorderSide(color: Colors.white, width: 2.0));
    expect(textFieldDecoration?.focusedBorder?.borderSide,
        const BorderSide(color: Colors.white, width: 2.0));

    // Test hint text
    expect(textFieldDecoration?.hintText, "Email address");
    expect(textFieldDecoration?.hintStyle?.color, Colors.white);
    expect(textFieldDecoration?.hintStyle?.fontWeight, FontWeight.w800);
    //expect(container.padding,const EdgeInsets.fromLTRB(0, 10, 0, 10));
  });

  testWidgets('Button group', (WidgetTester tester) async {
    await tester.wrapAndPumpWidget(MyHomePage());
    Iterable<Container> containerList =
        tester.widgetList(find.byType(Container));
    expect(containerList.last.padding, const EdgeInsets.fromLTRB(30, 0, 30, 0));
    expect(containerList.last.child, isA<Column>());
    ElevatedButton siginButton =
        tester.widget(find.widgetWithText(ElevatedButton, "Continue"));
    expect(siginButton.child, isA<Text>());
    Text textContinue = tester.widget(find.text("Continue"));
    expect(textContinue.style?.color, Colors.black);

    // TEST second BUtton
    Icon icon = tester.widget(find.byType(Icon));
    expect(icon.icon, Icons.add);
    expect(icon.color, Colors.black);

    // TEST Rich Text
    Iterable<RichText> richText = tester.widgetList(find.byType(RichText));
    expect(richText.last.textAlign, TextAlign.center);
    expect(richText.last.text, isA<TextSpan>());
  });

}

extension WidgetTesterExtension on WidgetTester {
  Future<void> wrapAndPumpWidget(Widget widget) async {
    await pumpWidget(MaterialApp(
      home: widget,
      theme: ThemeData(
        primaryColor: const Color(0xff006606),
        textTheme: const TextTheme(
          displayMedium: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w800), 
        ))
    ));
    await pump();
  }
}
