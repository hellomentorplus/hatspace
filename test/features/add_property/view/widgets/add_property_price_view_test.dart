import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_info_view/add_property_price_view.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../find_extension.dart';
import '../../../../widget_tester_extension.dart';
import 'add_property_price_view_test.mocks.dart';

@GenerateMocks([AddPropertyCubit])
void main() async {
  await HatSpaceStrings.load(Locale('en'));

  final MockAddPropertyCubit addPropertyCubit = MockAddPropertyCubit();

  setUpAll(() {
    when(addPropertyCubit.state).thenAnswer((realInvocation) => AddPropertyInitial());
    when(addPropertyCubit.stream).thenAnswer((realInvocation) => Stream.empty());
  });

  test('test ErrorType Strings', () {
    expect(ErrorType.priceIsEmpty.text, 'Enter price');
    expect(ErrorType.priceIsNotNumber.text, 'Only accept number');
  });

  group('verify error on UI', () {
    testWidgets('when text field is unfocus with empty text, then error is visible', (widgetTester) async {
      when(addPropertyCubit.price).thenAnswer((realInvocation) => null);
      const Widget widget = AddPropertyPriceView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(addPropertyCubit, widget);

      expect(find.byType(TextField), findsOneWidget);

      // focus on the text field
      await widgetTester.tap(find.byType(TextField));
      await widgetTester.pumpAndSettle();

      // then unfocus
      final HatSpaceInputText inputText = widgetTester.widget(find.byType(HatSpaceInputText)) as HatSpaceInputText;
      inputText.focusNode?.unfocus();
      await widgetTester.pumpAndSettle();

      // error text is visible
      expect(find.byTextWithColor('Enter price', const Color(0xFFD02D2D)), findsOneWidget);
    });

    testWidgets('when text field is unfocus with impersistent error, then error is gone', (widgetTester) async {
      when(addPropertyCubit.price).thenAnswer((realInvocation) => 25);
      const Widget widget = AddPropertyPriceView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(addPropertyCubit, widget);

      expect(find.byType(TextField), findsOneWidget);

      // enter invalid text
      await widgetTester.enterText(find.byType(TextField), 'text');
      await widgetTester.pumpAndSettle();
      // error text is visible
      expect(find.byTextWithColor('Only accept number', const Color(0xFFD02D2D)), findsOneWidget);

      // then unfocus
      final HatSpaceInputText inputText = widgetTester.widget(find.byType(HatSpaceInputText)) as HatSpaceInputText;
      inputText.focusNode?.unfocus();
      await widgetTester.pumpAndSettle();

      // error text is visible
      expect(find.byTextWithColor('Only accept number', const Color(0xFFD02D2D)), findsNothing);
    });

    testWidgets('when tap text then remove text, then error is visible', (widgetTester) async {
      const Widget widget = AddPropertyPriceView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(addPropertyCubit, widget);

      expect(find.byType(TextField), findsOneWidget);
      // hint text visible
      expect(find.byTextWithColor('Enter your price', const Color(0xFF8C8C8C)), findsOneWidget);

      // now enter text
      await widgetTester.enterText(find.byType(TextField), '356');
      await widgetTester.pumpAndSettle();

      // clear text
      await widgetTester.enterText(find.byType(TextField), '');
      await widgetTester.pumpAndSettle();
      // error text is visible
      expect(find.byTextWithColor('Enter price', const Color(0xFFD02D2D)), findsOneWidget);
    });

    testWidgets('when enter text not number or dot, then error is visible', (widgetTester) async {
      const Widget widget = AddPropertyPriceView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(addPropertyCubit, widget);

      expect(find.byType(TextField), findsOneWidget);

      // now enter text
      await widgetTester.enterText(find.byType(TextField), '245d');
      await widgetTester.pumpAndSettle();

      // error text is visible
      expect(find.byTextWithColor('Only accept number', const Color(0xFFD02D2D)), findsOneWidget);
    });

    testWidgets('when enter text with number and dot, then error is not visible', (widgetTester) async {
      const Widget widget = AddPropertyPriceView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(addPropertyCubit, widget);

      expect(find.byType(TextField), findsOneWidget);

      // now enter text
      await widgetTester.enterText(find.byType(TextField), '245.36');
      await widgetTester.pumpAndSettle();

      // error text is visible
      expect(find.byTextWithColor('Only accept number', const Color(0xFFD02D2D)), findsNothing);
    });

    testWidgets('when enter text with number and dot, and add dot after decimal dot, then error is visible', (widgetTester) async {
      const Widget widget = AddPropertyPriceView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(addPropertyCubit, widget);

      expect(find.byType(TextField), findsOneWidget);

      // now enter text
      await widgetTester.enterText(find.byType(TextField), '245.36.35');
      await widgetTester.pumpAndSettle();

      // error text is visible
      expect(find.byTextWithColor('Only accept number', const Color(0xFFD02D2D)), findsNothing);
    });

    testWidgets('when enter text with number and dot, then number is formatted with thousand separations', (widgetTester) async {
      const Widget widget = AddPropertyPriceView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(addPropertyCubit, widget);

      expect(find.byType(TextField), findsOneWidget);

      // now enter text
      await widgetTester.enterText(find.byType(TextField), '1256931.3625698');
      await widgetTester.pumpAndSettle();

      // number is formatted
      expect(find.text('1,256,931.3625698'), findsOneWidget);
    });
  });
}