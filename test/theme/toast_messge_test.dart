import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/toast_messages/hs_toast_theme.dart';
import '../widget_tester_extension.dart';

void main() {
  group('Checking Error Toast UI', () {
    testWidgets('Test Error Message Toast Widget', (WidgetTester tester) async {
      ToastMessageContainer errorToast = const ToastMessageContainer(
        toastType: ToastType.errorToast,
        toastTitle: 'Error Title',
        toastContent: 'Error Message',
      );
      await tester.wrapAndPump(errorToast);
      Text textTitle = tester.widget(find.text('Error Title'));
      expect(reason: 'Check title max line', textTitle.maxLines, 2);
      expect(
          reason: 'Check overflow', textTitle.overflow, TextOverflow.ellipsis);
      expect(
          reason: 'Check Style', textTitle.style?.fontWeight, FontWeight.w700);
      expect(reason: 'Check text style', textTitle.style?.fontSize, 14);
      expect(
          reason: 'Check Color',
          textTitle.style?.color,
          const Color(0xff141414));

      Text messageText = tester.widget(find.text('Error Message'));
      expect(reason: 'Check title max line', messageText.maxLines, 2);
      expect(
          reason: 'Check overflow',
          messageText.overflow,
          TextOverflow.ellipsis);
      expect(
          reason: 'Check Style',
          messageText.style?.fontWeight,
          FontWeight.w400);
      expect(reason: 'Check text style', messageText.style?.fontSize, 12);
      expect(
          reason: 'Check Color',
          messageText.style?.color,
          const Color(0xff383838));

      Container container = tester.firstWidget(find.byType(Container));
      expect(
          reason: 'Check Box Decoration Style',
          container.decoration,
          BoxDecoration(
              borderRadius: BorderRadius.circular(6), color: HSColor.neutral1));
      expect(
          reason: 'Checking padding',
          container.padding,
          const EdgeInsets.all(12));
      Row row = tester.firstWidget(find.descendant(
          of: find.byType(Container), matching: find.byType(Row)));
      expect(
          reason: 'Check main and cross axis',
          row.crossAxisAlignment,
          CrossAxisAlignment.start);
      expect(
          reason: 'Check main and cross axis',
          row.mainAxisAlignment,
          MainAxisAlignment.spaceEvenly);
      expect(row.children.first, isA<SvgPicture>());
      expect(row.children.last, isA<Flexible>());

      Flexible flex = tester.firstWidget(find.byType(Flexible));
      expect(flex.child, isA<Padding>());
      Column col = tester.firstWidget(find.byType(Column));
      expect(col.crossAxisAlignment, CrossAxisAlignment.start);
    });
  });
}
