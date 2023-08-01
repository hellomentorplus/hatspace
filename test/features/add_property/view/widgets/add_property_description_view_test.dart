import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_info_view/add_property_description_view.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../widget_tester_extension.dart';
import 'add_property_description_view_test.mocks.dart';

@GenerateMocks([AddPropertyCubit])
void main() {
  final MockAddPropertyCubit addPropertyCubit = MockAddPropertyCubit();

  setUp(() {
    when(addPropertyCubit.state).thenReturn(AddPropertyInitial());
    when(addPropertyCubit.stream)
        .thenAnswer((realInvocation) => Stream.empty());
  });

  tearDown(() {
    reset(addPropertyCubit);
  });

  testWidgets(
      'given description field is empty,'
      'when load UI,'
      'then counter is 0', (widgetTester) async {
    final Widget widget = AddPropertyDescriptionView();

    await widgetTester.blocWrapAndPump<AddPropertyCubit>(
        addPropertyCubit, widget);

    expect(find.text('0/4000'), findsOneWidget);
  });

  testWidgets(
      'given description field has 6 chars,'
      'when load UI,'
      'then counter is 6/4000', (widgetTester) async {
    final Widget widget = AddPropertyDescriptionView();

    await widgetTester.blocWrapAndPump<AddPropertyCubit>(
        addPropertyCubit, widget);
    await widgetTester.enterText(find.byType(TextFormField), 'abcdef');
    await widgetTester.pumpAndSettle();

    expect(find.text('6/4000'), findsOneWidget);
  });

  testWidgets(
      'given description field has more than 4000 chars,'
      'when load UI,'
      'then counter is 4000/4000,'
      'and new char is not added', (widgetTester) async {
    final Widget widget = AddPropertyDescriptionView();

    await widgetTester.blocWrapAndPump<AddPropertyCubit>(
        addPropertyCubit,
        SingleChildScrollView(
          child: widget,
        ));

    String maxChars = List.filled(4000, 'a').toString();
    await widgetTester.enterText(find.byType(TextFormField), maxChars);
    await widgetTester.pumpAndSettle();

    expect(find.text('4000/4000'), findsOneWidget);

    final String exceededChar = '${maxChars}bb';
    await widgetTester.enterText(find.byType(TextFormField), exceededChar);
    await widgetTester.pumpAndSettle();

    expect(find.text('4000/4000'), findsOneWidget);
    expect(find.text(exceededChar), findsNothing);
  });
}
