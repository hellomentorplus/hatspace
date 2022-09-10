import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/Screen/VerificationScreen.dart';

void main(){
testWidgets("Page layout testing", (WidgetTester tester) async {
    await tester.wrapAndPumpWidget(const VerificationPage(
      emailValue: "",
    ));
    //  try{
    Scaffold scaffold = tester.firstWidget(find.byType(Scaffold));
    expect(scaffold.body, isA<Padding>());
    Padding pagePadding = tester.firstWidget(find.byType(Padding));
    expect(pagePadding.padding, const EdgeInsets.only(left: 20, right: 20));
    expect(pagePadding.child, isA<Column>());
    Iterable<Column> outerCol = tester.widgetList(find.byType(Column));
    expect(
        outerCol.elementAt(0).mainAxisAlignment, MainAxisAlignment.spaceAround);
    expect(
        outerCol.elementAt(0).crossAxisAlignment, CrossAxisAlignment.stretch);
    Iterable<Container> containerList = tester.widgetList(find.byType(Container));
    expect(containerList.elementAt(0).margin,
        const EdgeInsets.only(top: 60.0, bottom: 20.0));
    Text spaceApp = tester.widget(find.text("Space App"));
expect(spaceApp.style?.color, Colors.white);
    expect(spaceApp.style?.fontSize, 16);
    expect(spaceApp.textAlign, TextAlign.center);
    expect(spaceApp.style?.fontWeight, FontWeight.w800);
    expect(containerList.elementAt(1).padding, const EdgeInsets.only(left: 100, right: 100));
    expect(containerList.elementAt(1).child,isA<Text>());

    Text emailConfirm = tester.widget(find.descendant(of: find.byWidget(containerList.elementAt(1)), matching: find.byType(Text)));
    expect(emailConfirm.style?.color, Colors.white);
    expect(emailConfirm.softWrap,true);
    expect(emailConfirm.textAlign, TextAlign.center);

    expect(containerList.elementAt(2).padding, const EdgeInsets.only(left: 20,right: 20));
    expect (containerList.elementAt(2).margin, const EdgeInsets.only(top:15, bottom: 15));

    Text tempText = tester.widget(find.descendant(of: find.byWidget(containerList.elementAt(2)), matching: find.byType(Text)));
  

    TextField textField = tester.widget(find.byType(TextField));
    expect(textField.style?.color,Colors.white);
    InputDecoration? textFieldDec = textField.decoration;
    expect(textField.decoration, textFieldDec);
    expect(textField.decoration?.hintText, "Enter Pin");
    expect(textField.decoration?.hintStyle?.fontSize, 20);
  });

  // testWidgets("Page Content", (WidgetTester tester)async {
    
  // });
}

extension WidgetTesterExtension on WidgetTester{
  Future<void> wrapAndPumpWidget(Widget widget)async{
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