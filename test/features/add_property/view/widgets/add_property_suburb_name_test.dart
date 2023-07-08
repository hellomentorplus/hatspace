import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_info_view/add_property_suburb.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../find_extension.dart';
import '../../../../widget_tester_extension.dart';
import 'add_property_suburb_name_test.mocks.dart';

@GenerateMocks([AddPropertyCubit])
void main() async {
  await HatSpaceStrings.load(const Locale('en'));

  final MockAddPropertyCubit addPropertyCubit = MockAddPropertyCubit();

  setUpAll(() {
    when(addPropertyCubit.state)
        .thenAnswer((realInvocation) => const AddPropertyInitial());
    when(addPropertyCubit.stream)
        .thenAnswer((realInvocation) => const Stream.empty());
  });

  test(
    'test ErrorType String extension',
    () {
      // suburb strings
      expect(ErrorType.maxLength.suburbError, 'Maximum 40 characters');
      expect(ErrorType.hasInvalidCharacters.suburbError, 'Only accept text');
      expect(ErrorType.isEmpty.suburbError, 'Enter suburb');

      // postal code strings
      expect(ErrorType.maxLength.postalError, 'Maximum 10 characters');
      expect(ErrorType.isEmpty.postalError, 'Enter postcode');
      expect(ErrorType.hasInvalidCharacters.postalError, 'Only accept number');
    },
  );

  group('test Errors on UI', () {
    testWidgets(
        'when suburb text field is unfocus with empty text, then error is visible',
        (widgetTester) async {
      when(addPropertyCubit.suburb).thenAnswer((realInvocation) => '');
      when(addPropertyCubit.postalCode).thenAnswer((realInvocation) => null);

      const Widget widget = AddPropertySuburbView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyCubit, widget);

      /// focus and unfocus suburb field
      expect(find.findHatSpaceInputTextWithLabel('Suburb'), findsOneWidget);

      // focus on the text field
      final HatSpaceInputText suburbField =
          widgetTester.widget(find.findHatSpaceInputTextWithLabel('Suburb'))
              as HatSpaceInputText;
      suburbField.focusNode?.requestFocus();
      await widgetTester.pumpAndSettle();

      // then unfocus
      suburbField.focusNode?.unfocus();
      await widgetTester.pumpAndSettle();

      // error text is visible
      expect(find.byTextWithColor('Enter suburb', const Color(0xFFD02D2D)),
          findsOneWidget);

      /// focus and unfocus postal code field
      expect(find.findHatSpaceInputTextWithLabel('Postcode'), findsOneWidget);

      // focus on the text field
      final HatSpaceInputText postCodeField =
          widgetTester.widget(find.findHatSpaceInputTextWithLabel('Postcode'))
              as HatSpaceInputText;
      postCodeField.focusNode?.requestFocus();
      await widgetTester.pumpAndSettle();

      // then unfocus
      postCodeField.focusNode?.unfocus();
      await widgetTester.pumpAndSettle();

      // error text is visible
      expect(find.byTextWithColor('Enter postcode', const Color(0xFFD02D2D)),
          findsOneWidget);
    });

    testWidgets(
        'when text field is unfocus with impersistent error, then error is gone',
        (widgetTester) async {
      when(addPropertyCubit.price).thenAnswer((realInvocation) => 25);
      const Widget widget = AddPropertySuburbView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyCubit, widget);

      /// suburb only accept text
      // enter invalid text
      await widgetTester.enterText(
          find.findHatSpaceInputTextWithLabel('Suburb'), '1234');
      await widgetTester.pumpAndSettle();
      // error text is visible
      expect(find.byTextWithColor('Only accept text', const Color(0xFFD02D2D)),
          findsOneWidget);

      // then unfocus
      final HatSpaceInputText suburbText =
          widgetTester.widget(find.findHatSpaceInputTextWithLabel('Suburb'))
              as HatSpaceInputText;
      suburbText.focusNode?.unfocus();
      await widgetTester.pumpAndSettle();

      // error text is visible
      expect(find.byTextWithColor('Only accept text', const Color(0xFFD02D2D)),
          findsNothing);

      /// postal only accept text
      // enter invalid text
      await widgetTester.enterText(
          find.findHatSpaceInputTextWithLabel('Postcode'), 'abcd');
      await widgetTester.pumpAndSettle();
      // error text is visible
      expect(
          find.byTextWithColor('Only accept number', const Color(0xFFD02D2D)),
          findsOneWidget);

      // then unfocus
      final HatSpaceInputText postalText =
          widgetTester.widget(find.findHatSpaceInputTextWithLabel('Postcode'))
              as HatSpaceInputText;
      postalText.focusNode?.unfocus();
      await widgetTester.pumpAndSettle();

      // error text is visible
      expect(
          find.byTextWithColor('Only accept number', const Color(0xFFD02D2D)),
          findsNothing);
    });

    testWidgets('when tap text then remove text, then error is visible',
        (widgetTester) async {
      when(addPropertyCubit.suburb).thenAnswer((realInvocation) => '');
      when(addPropertyCubit.postalCode).thenAnswer((realInvocation) => null);

      const Widget widget = AddPropertySuburbView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyCubit, widget);

      /// test on suburb field
      // now enter text
      await widgetTester.enterText(
          find.findHatSpaceInputTextWithLabel('Suburb'), 'suburb');
      await widgetTester.pumpAndSettle();

      // clear text
      await widgetTester.enterText(
          find.findHatSpaceInputTextWithLabel('Suburb'), '');
      await widgetTester.pumpAndSettle();
      // error text is visible
      expect(find.byTextWithColor('Enter suburb', const Color(0xFFD02D2D)),
          findsOneWidget);

      /// test on postal code field
      // now enter text
      await widgetTester.enterText(
          find.findHatSpaceInputTextWithLabel('Postcode'), '3625');
      await widgetTester.pumpAndSettle();

      // clear text
      await widgetTester.enterText(
          find.findHatSpaceInputTextWithLabel('Postcode'), '');
      await widgetTester.pumpAndSettle();
      // error text is visible
      expect(find.byTextWithColor('Enter postcode', const Color(0xFFD02D2D)),
          findsOneWidget);
    });

    testWidgets(
        'when enter suburb text longer than 40 characters, then error is visible',
        (widgetTester) async {
      const Widget widget = AddPropertySuburbView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyCubit, widget);

      // now enter text
      await widgetTester.enterText(
          find.findHatSpaceInputTextWithLabel('Suburb'),
          String.fromCharCodes(List.filled(41, 0)));
      await widgetTester.pumpAndSettle();

      // error text is visible
      expect(
          find.byTextWithColor(
              'Maximum 40 characters', const Color(0xFFD02D2D)),
          findsOneWidget);
    });

    testWidgets(
        'when enter suburb text longer than 10 characters, then error is visible',
        (widgetTester) async {
      const Widget widget = AddPropertySuburbView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyCubit, widget);

      // now enter text
      await widgetTester.enterText(
          find.findHatSpaceInputTextWithLabel('Postcode'),
          String.fromCharCodes(List.filled(11, 0)));
      await widgetTester.pumpAndSettle();

      // error text is visible
      expect(
          find.byTextWithColor(
              'Maximum 10 characters', const Color(0xFFD02D2D)),
          findsOneWidget);
    });

    testWidgets(
        'when enter suburb text with dot and space and comma, then error is not visible',
        (widgetTester) async {
      const Widget widget = AddPropertySuburbView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyCubit, widget);

      // now enter text
      await widgetTester.enterText(
          find.findHatSpaceInputTextWithLabel('Suburb'),
          'this text has . and , and space');
      await widgetTester.pumpAndSettle();

      // error text is visible
      expect(find.byTextWithColor('Only accept text', const Color(0xFFD02D2D)),
          findsNothing);
    });

    testWidgets(
        'when enter postal text with number only, then error is not visible',
        (widgetTester) async {
      const Widget widget = AddPropertySuburbView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyCubit, widget);

      // now enter text
      await widgetTester.enterText(
          find.findHatSpaceInputTextWithLabel('Postcode'), '3625');
      await widgetTester.pumpAndSettle();

      // error text is visible
      expect(
          find.byTextWithColor('Only accept number', const Color(0xFFD02D2D)),
          findsNothing);
    });

    testWidgets(
        'when enter suburb text with number and invalid chars, then error is visible',
        (widgetTester) async {
      const Widget widget = AddPropertySuburbView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyCubit, widget);

      // now enter text
      await widgetTester.enterText(
          find.findHatSpaceInputTextWithLabel('Suburb'), 'this is 2 numbers *');
      await widgetTester.pumpAndSettle();

      // error text is visible
      expect(find.byTextWithColor('Only accept text', const Color(0xFFD02D2D)),
          findsOneWidget);
    });

    testWidgets(
        'when enter postal with text and invalid chars, then error is visible',
        (widgetTester) async {
      const Widget widget = AddPropertySuburbView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyCubit, widget);

      // now enter text
      await widgetTester.enterText(
          find.findHatSpaceInputTextWithLabel('Postcode'), '2 *');
      await widgetTester.pumpAndSettle();

      // error text is visible
      expect(
          find.byTextWithColor('Only accept number', const Color(0xFFD02D2D)),
          findsOneWidget);
    });
  });
}
