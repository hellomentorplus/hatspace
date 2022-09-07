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

import 'package:hatspace/main.dart';

void main() {
  test("main", (){
    expect(WidgetsFlutterBinding.ensureInitialized(), WidgetsFlutterBinding.ensureInitialized());
  });
  testWidgets('Home Screen - main outtr column', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.wrapAndPumpWidget(MyHomePage());

    // Column parentCol = tester.widget(find.ancestor(of: find.byType(Container), matching: find.byType(Column)));

    Scaffold scaffold = tester.widget(find.byType(Scaffold));
    Iterable<Column> parentCol = tester.widgetList(find.byType(Column));
    expect(parentCol.first.mainAxisAlignment, MainAxisAlignment.spaceAround);
    expect(parentCol.first.crossAxisAlignment, CrossAxisAlignment.stretch);

    // Getting the widget
  });
  testWidgets('Home Screen - header', (WidgetTester tester) async {
    // Build our app and trigger a frame.
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
    expect(headerText.style?.fontWeight, FontWeight.bold);
    expect(headerText.style?.fontSize, 65);

    Iterable<Container> containerList =
        tester.widgetList(find.byType(Container));
    //============
    expect(containerList.elementAt(2).padding,
        const EdgeInsets.fromLTRB(0, 10, 0, 10));
    Text text = tester.widget(find.text("Please enter your email address"));
    expect(text.style?.color, Colors.white);
    expect(text.style?.fontSize, 20);
    expect(text.style?.fontWeight, FontWeight.w500);

    //=============
    expect(containerList.elementAt(3).padding,
        const EdgeInsets.fromLTRB(30, 20, 30, 20));
    expect(containerList.elementAt(3).child, isA<TextField>());
    TextField textField = tester.widget(find.byType(TextField));
    TextStyle? textFieldStyle = textField.style;
    expect(textFieldStyle?.color, Colors.white);
    expect(textField.style?.fontWeight, FontWeight.w500);

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
    expect(textFieldDecoration?.hintStyle?.fontWeight, FontWeight.w500);
    expect(textFieldDecoration?.hintStyle?.fontSize, 20);
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
    expect(textContinue.style?.fontSize, 20);

    // TEST second BUtton
    Icon icon = tester.widget(find.byType(Icon));
    expect (icon.icon, Icons.add );
    expect (icon.color, Colors.black);

    // TEST Rich Text 
    Iterable <RichText> richText  = tester.widgetList(find.byType(RichText));
    expect(richText.last.textAlign, TextAlign.center);
    expect(richText.last.text, isA<TextSpan>());
  });
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
