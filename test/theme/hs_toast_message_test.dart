import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/hs_toast_theme.dart';
import '../widget_tester_extension.dart';

void main() {
  const messageTest = "Test Theme";
  RoundedRectangleBorder toastStyle = const RoundedRectangleBorder(
      side: BorderSide(style: BorderStyle.solid, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(4)));
  testWidgets("Successful toast theme", (WidgetTester tester) async {
    Widget successfulToastMessage =
        const ToastMessageSuccess(message: messageTest);
    await tester.wrapAndPump(successfulToastMessage);

    Card toastMessage = tester.firstWidget(find.byKey(const Key(messageTest)));
    expect(toastMessage.color, HSColor.statusSuccess.withOpacity(0.3),
        reason: "Checking toast message color");
    expect(
        toastMessage.shape,
        toastStyle.copyWith(
            side: toastStyle.side.copyWith(color: HSColor.statusSuccess)),
        reason: "Checking toast message format");

    expect(toastMessage.child, isA<Padding>());
    // Padding (Padding(padding: EdgeInsets(24.0, 12.0, 24.0, 12.0)))
    Row row = tester.widget(find.byType(Row));
    Widget childOfFirst = row.children.elementAt(0);

    SvgPicture icon = tester.widget(find.descendant(
        of: find.byWidget(childOfFirst), matching: find.byType(SvgPicture)));
  });

  testWidgets("Error toast theme", (WidgetTester tester) async {
    Widget errorToastMessage = const ToastMessageError(message: messageTest);
    await tester.wrapAndPump(errorToastMessage);

    Card toastMessage = tester.firstWidget(find.byKey(const Key(messageTest)));
    expect(toastMessage.color, HSColor.statusError.withOpacity(0.3),
        reason: "Checking toast message color");
    expect(
        toastMessage.shape,
        toastStyle.copyWith(
            side: toastStyle.side.copyWith(color: HSColor.statusError)),
        reason: "Checking toast message format");

    expect(toastMessage.child, isA<Padding>());
    // Padding (Padding(padding: EdgeInsets(24.0, 12.0, 24.0, 12.0)))
    Row row = tester.widget(find.byType(Row));
    Widget childOfFirst = row.children.elementAt(0);

    SvgPicture icon = tester.widget(find.descendant(
        of: find.byWidget(childOfFirst), matching: find.byType(SvgPicture)));
  });

  testWidgets("Warning toast theme", (WidgetTester tester) async {
    Widget warningToastMessage =
        const ToastMessageWarning(message: messageTest);
    await tester.wrapAndPump(warningToastMessage);

    Card toastMessage = tester.firstWidget(find.byKey(const Key(messageTest)));
    expect(toastMessage.color, HSColor.statusWarning.withOpacity(0.3),
        reason: "Checking toast message color");
    expect(
        toastMessage.shape,
        toastStyle.copyWith(
            side: toastStyle.side.copyWith(color: HSColor.statusWarning)),
        reason: "Checking toast message format");

    expect(toastMessage.child, isA<Padding>());
    // Padding (Padding(padding: EdgeInsets(24.0, 12.0, 24.0, 12.0)))
    Row row = tester.widget(find.byType(Row));
    Widget childOfFirst = row.children.elementAt(0);

    SvgPicture icon = tester.widget(find.descendant(
        of: find.byWidget(childOfFirst), matching: find.byType(SvgPicture)));
  });

  testWidgets("Info toast theme", (WidgetTester tester) async {
    Widget infoToastMessage = const ToastMessageInfo(message: messageTest);
    await tester.wrapAndPump(infoToastMessage);

    Card toastMessage = tester.firstWidget(find.byKey(const Key(messageTest)));
    expect(toastMessage.color, HSColor.statusInformational.withOpacity(0.3),
        reason: "Checking toast message color");
    expect(
        toastMessage.shape,
        toastStyle.copyWith(
            side: toastStyle.side.copyWith(color: HSColor.statusInformational)),
        reason: "Checking toast message format");

    expect(toastMessage.child, isA<Padding>());
    // Padding (Padding(padding: EdgeInsets(24.0, 12.0, 24.0, 12.0)))
    Row row = tester.widget(find.byType(Row));
    Widget childOfFirst = row.children.elementAt(0);

    SvgPicture icon = tester.widget(find.descendant(
        of: find.byWidget(childOfFirst), matching: find.byType(SvgPicture)));
  });
}
