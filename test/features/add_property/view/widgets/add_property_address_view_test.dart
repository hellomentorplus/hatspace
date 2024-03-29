import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_info_view/add_property_address_view.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/theme/widgets/hs_text_field.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../widget_tester_extension.dart';
import 'add_property_address_view_test.mocks.dart';

@GenerateMocks([AddPropertyCubit])
void main() {
  final MockAddPropertyCubit addPropertyCubit = MockAddPropertyCubit();

  setUp(() {
    when(addPropertyCubit.state)
        .thenAnswer((realInvocation) => const AddPropertyInitial());
    when(addPropertyCubit.stream)
        .thenAnswer((realInvocation) => const Stream.empty());
  });

  tearDown(() {
    reset(addPropertyCubit);
  });

  testWidgets('verify UI component', (widgetTester) async {
    const Widget widget = AddPropertyAddressView();

    await widgetTester.wrapAndPump(widget);

    expect(find.byType(HatSpaceInputText), findsOneWidget);
    expect(find.text('Street address *', findRichText: true), findsOneWidget);
    expect(find.text('Enter street address'), findsOneWidget);
  });

  group('verify to set address value when value  change', () {
    testWidgets(
        'given address is blank,'
        'when change to not blank,'
        'then cubit address is updated', (widgetTester) async {
      const Widget widget = AddPropertyAddressView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyCubit, widget);

      await widgetTester.enterText(
          find.byType(HatSpaceInputText), 'address text');
      await widgetTester.pumpAndSettle();

      expect(find.text('address text'), findsOneWidget);
      verify(addPropertyCubit.address = 'address text').called(1);
    });

    testWidgets(
        'given address is blank,'
        'when focus out,'
        'then show error', (widgetTester) async {
      when(addPropertyCubit.address).thenReturn('');
      const Widget widget = AddPropertyAddressView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyCubit, widget);

      // focus on the text field
      await widgetTester.tap(find.byType(TextField));
      await widgetTester.pumpAndSettle();

      // then unfocus
      final HatSpaceInputText inputText = widgetTester
          .widget(find.byType(HatSpaceInputText)) as HatSpaceInputText;
      inputText.focusNode?.unfocus();
      await widgetTester.pumpAndSettle();

      // 1 hint, 1 error
      expect(find.text('Enter street address'), findsNWidgets(2));
    });

    testWidgets(
        'given address is not blank,'
        'when clear address text,'
        'then show error', (widgetTester) async {
      const Widget widget = AddPropertyAddressView();

      await widgetTester.blocWrapAndPump<AddPropertyCubit>(
          addPropertyCubit, widget);

      await widgetTester.enterText(
          find.byType(HatSpaceInputText), 'address text');
      await widgetTester.pumpAndSettle();

      expect(find.text('address text'), findsOneWidget);

      await widgetTester.enterText(find.byType(HatSpaceInputText), '');
      await widgetTester.pumpAndSettle();
      expect(find.text('address text'), findsNothing);
      // 1 hint, 1 error
      expect(find.text('Enter street address'), findsNWidgets(2));
    });
  });
}
