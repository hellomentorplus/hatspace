import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_info_view/add_property_name_view.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../find_extension.dart';
import '../../../../widget_tester_extension.dart';
import 'add_property_name_view_test.mocks.dart';

@GenerateMocks([AddPropertyCubit])
void main() async {
  await HatSpaceStrings.load(Locale('en'));

  final MockAddPropertyCubit addPropertyCubit = MockAddPropertyCubit();

  setUpAll(() {
    when(addPropertyCubit.state)
        .thenAnswer((realInvocation) => AddPropertyInitial());
    when(addPropertyCubit.stream)
        .thenAnswer((realInvocation) => Stream.empty());
  });

  group('Test ErrorType data', () {
    test(
      'ensure text extracts correctly',
      () {
        expect(ErrorType.nameIsEmpty.text, 'Enter property name');
        expect(ErrorType.nameContainsInvalidChars.text, 'Only accept text');
        expect(ErrorType.nameExceed30Chars.text, 'Maximum 30 characters');
      },
    );

    test(
      'validate nameIsEmpty check',
      () {
        // given empty string, then return true
        expect(ErrorType.nameIsEmpty.check(''), isTrue);

        // given none empty string, then return false;
        expect(ErrorType.nameIsEmpty.check('name'), isFalse);
      },
    );

    test(
      'validate max length check',
      () {
        // given string below 30 character, then return false
        expect(ErrorType.nameExceed30Chars.check('short string'), isFalse);

        // given string is 30 characters, then return false
        expect(
            ErrorType.nameExceed30Chars
                .check(String.fromCharCodes(List<int>.filled(30, 0))),
            isFalse);

        // given string is more than 30 characters, then return true
        expect(
            ErrorType.nameExceed30Chars
                .check(String.fromCharCodes(List<int>.filled(31, 0))),
            isTrue);
      },
    );

    test(
      'validate nameContainsInvalidChars',
      () {
        // given string with alphabets, space, and comma and dot only, then return false
        expect(
            ErrorType.nameContainsInvalidChars
                .check('text and space and comma, and dot.'),
            isFalse);

        // given string contains number, then return true
        expect(ErrorType.nameContainsInvalidChars.check('text with number 1'),
            isTrue);

        // given string contains invalid char, then return true
        expect(
            ErrorType.nameContainsInvalidChars.check('invalid \u002A'), isTrue);
      },
    );
  });

  group('verify error scenarios on UI', () {
    testWidgets('when tap text then remove text, then error is visible',
        (widgetTester) async {
      const Widget widget = AddPropertyNameView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyCubit, widget);

      expect(find.byType(TextField), findsOneWidget);
      // hint text visible
      expect(
          find.byTextWithColor('Enter property name', const Color(0xFF8C8C8C)),
          findsOneWidget);

      // now enter text
      await widgetTester.enterText(find.byType(TextField), 'text');
      await widgetTester.pumpAndSettle();
      // hint text is gone
      expect(
          find.byTextWithColor('Enter property name', const Color(0xFF8C8C8C)),
          findsOneWidget);

      // clear text
      await widgetTester.enterText(find.byType(TextField), '');
      await widgetTester.pumpAndSettle();
      // error text is visible
      expect(
          find.byTextWithColor('Enter property name', const Color(0xFFD02D2D)),
          findsOneWidget);
    });

    testWidgets(
        'given error is visible, when enter valid text, then error is gone',
        (widgetTester) async {
      const Widget widget = AddPropertyNameView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyCubit, widget);

      // now enter text
      await widgetTester.enterText(find.byType(TextField), 'text');
      // clear text
      await widgetTester.enterText(find.byType(TextField), '');
      await widgetTester.pumpAndSettle();
      // error text is visible
      expect(
          find.byTextWithColor('Enter property name', const Color(0xFFD02D2D)),
          findsOneWidget);

      // continue to enter valid text
      await widgetTester.enterText(find.byType(TextField), 'new text valid');
      await widgetTester.pumpAndSettle();

      // error text is gone
      expect(
          find.byTextWithColor('Enter property name', const Color(0xFFD02D2D)),
          findsNothing);
    });

    testWidgets('when enter invalid text, then error is visible',
        (widgetTester) async {
      const Widget widget = AddPropertyNameView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyCubit, widget);

      expect(find.byType(TextField), findsOneWidget);

      // enter invalid text
      await widgetTester.enterText(
          find.byType(TextField), 'invalid text: there it is');
      await widgetTester.pumpAndSettle();
      // error text is visible
      expect(find.byTextWithColor('Only accept text', const Color(0xFFD02D2D)),
          findsOneWidget);
    });

    testWidgets('when enter more than 30 characters, then error is visible',
        (widgetTester) async {
      const Widget widget = AddPropertyNameView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyCubit, widget);

      expect(find.byType(TextField), findsOneWidget);

      // enter invalid text
      await widgetTester.enterText(find.byType(TextField),
          'this is a very long text which will be above 30 characters');
      await widgetTester.pumpAndSettle();
      // error text is visible
      expect(
          find.byTextWithColor(
              'Maximum 30 characters', const Color(0xFFD02D2D)),
          findsOneWidget);
    });

    testWidgets(
        'when text field is unfocus with empty text, then error is visible',
        (widgetTester) async {
      when(addPropertyCubit.propertyName).thenAnswer((realInvocation) => '');
      const Widget widget = AddPropertyNameView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyCubit, widget);

      expect(find.byType(TextField), findsOneWidget);

      // focus on the text field
      await widgetTester.tap(find.byType(TextField));
      await widgetTester.pumpAndSettle();

      // then unfocus
      final HatSpaceInputText inputText = widgetTester
          .widget(find.byType(HatSpaceInputText)) as HatSpaceInputText;
      inputText.focusNode?.unfocus();
      await widgetTester.pumpAndSettle();

      // error text is visible
      expect(
          find.byTextWithColor('Enter property name', const Color(0xFFD02D2D)),
          findsOneWidget);
    });

    testWidgets(
        'when text field is unfocus with impersistent error, then error is gone',
        (widgetTester) async {
      when(addPropertyCubit.propertyName).thenAnswer((realInvocation) => '');
      const Widget widget = AddPropertyNameView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyCubit, widget);

      expect(find.byType(TextField), findsOneWidget);

      // enter invalid text
      await widgetTester.enterText(
          find.byType(TextField), 'invalid text: there it is');
      await widgetTester.pumpAndSettle();
      // error text is visible
      expect(find.byTextWithColor('Only accept text', const Color(0xFFD02D2D)),
          findsOneWidget);

      // then unfocus
      final HatSpaceInputText inputText = widgetTester
          .widget(find.byType(HatSpaceInputText)) as HatSpaceInputText;
      inputText.focusNode?.unfocus();
      await widgetTester.pumpAndSettle();

      // error text is visible
      expect(find.byTextWithColor('Only accept text', const Color(0xFFD02D2D)),
          findsNothing);
    });
  });
}
