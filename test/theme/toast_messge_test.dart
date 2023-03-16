import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/theme/toast_messages/hs_toast_theme.dart';
import 'package:hatspace/theme/toast_messages/toast_messages_extension.dart';
import '../widget_tester_extension.dart';

void main() {
  group("Checking Error Toast UI", () {
    testWidgets("Test Error Message Toast Widget", (WidgetTester tester) async {
      ToastMessageContainer errorToast = const ToastMessageContainer(
        toastType: ToastType.errorToast,
        toastTitle: "Error Title",
        toastContent: "Error Message",
      );
      await tester.wrapAndPump(errorToast);
      Text textTitle = tester.widget(find.text("Error Title"));
      expect(reason: "Check title max line", textTitle.maxLines, 2);
      expect(
          reason: "Check overflow", textTitle.overflow, TextOverflow.ellipsis);
      expect(
          reason: "Check Style", textTitle.style?.fontWeight, FontWeight.w700);
      expect(reason: "Check text style", textTitle.style?.fontSize, 14);
      expect(
          reason: "Check Color",
          textTitle.style?.color,
          const Color(0xff141414));

      Text messageText = tester.widget(find.text("Error Message"));
      expect(reason: "Check title max line", messageText.maxLines, 2);
      expect(
          reason: "Check overflow",
          messageText.overflow,
          TextOverflow.ellipsis);
      expect(
          reason: "Check Style",
          messageText.style?.fontWeight,
          FontWeight.w400);
      expect(reason: "Check text style", messageText.style?.fontSize, 12);
      expect(
          reason: "Check Color",
          messageText.style?.color,
          const Color(0xff383838));

      Container container = tester.firstWidget(find.byType(Container));
      expect(
          reason: "Check Box Decoration Style",
          container.decoration,
          BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color.fromARGB(255, 255, 241, 241)));
      expect(
          reason: "Checking padding",
          container.padding,
          const EdgeInsets.all(12));
      Row row = tester.firstWidget(find.descendant(
          of: find.byType(Container), matching: find.byType(Row)));
      expect(
          reason: "Check main and cross axis",
          row.crossAxisAlignment,
          CrossAxisAlignment.start);
      expect(
          reason: "Check main and cross axis",
          row.mainAxisAlignment,
          MainAxisAlignment.spaceEvenly);
      expect(row.children.first, isA<SvgPicture>());
      expect(row.children.last, isA<Flexible>());

      Flexible flex = tester.firstWidget(find.byType(Flexible));
      expect(flex.child, isA<Padding>());
      Column col = tester.firstWidget(find.byType(Column));
      expect(col.crossAxisAlignment, CrossAxisAlignment.start);
    });

    group("Test toast functions", () {
      testWidgets("Test show toast and close toast function",
          ((WidgetTester tester) async {
        Widget testWidget = Builder(builder: (context) {
          return Center(
              child: ElevatedButton(
            key: const Key("tap-show-toast"),
            onPressed: () {
              context.showToast(ToastType.errorToast, "test title", "message");
            },
            child: const Text("show toast"),
          ));
        });

        await tester.wrapAndPump(testWidget);
        // First: Ensure no toast rendered
        expect(find.text("test title"), findsNothing);
        await tester.tap(find.byKey(const Key("tap-show-toast")));
        // Even after tap, toast has not been displayed at this time
        expect(find.text("test title"), findsNothing);
        await tester.pump(); // schedule animation => Toast should be shown after this time
        expect(find.text("test title"), findsOneWidget);
        await tester.pump(const Duration(milliseconds: 750));
        expect(find.text("test title"), findsOneWidget);
        // Second: Toast should dismiss after 6 seconds
        await tester.pump(const Duration(seconds: 6));
        // however, that the second 6th, toast has not been dismissed yet
        expect(find.text("test title"), findsOneWidget);
        // Add a bit millisecond, toast now should be dismissed
        await tester.pump(const Duration(milliseconds: 750));
        expect(find.text("test title"), findsNothing);

        // Cover close toast function
        // Show toast process is the same as the one above
        expect(find.text("test title"), findsNothing);
        await tester.tap(find.byKey(const Key("tap-show-toast")));
        expect(find.text("test title"), findsNothing);
        await tester.pump(); // schedule animation
        // Toast should be shown now then action to close toast
        GestureDetector closeToast = tester.firstWidget(find.byKey(const Key("closeTap")));
        await tester.tap(find.byKey(const Key("closeTap")));
        // after closeTap get tapped => widget should not be shown now
        await tester.pump();
        // add 750 milsec => toast now can be dismissed
        await tester.pump(const Duration(milliseconds: 750));
        expect(find.text("test title"), findsNothing);
      }));
    });
  });
}