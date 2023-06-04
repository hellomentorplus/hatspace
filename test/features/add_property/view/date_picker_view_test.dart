import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property/view/date_picker_view.dart';
import 'package:hatspace/features/add_property/view_model/cubit/property_type_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../../widget_tester_extension.dart';
import 'select_property_type_test.mocks.dart';

@GenerateMocks([PropertyTypeCubit])
void main() {
  final MockPropertyTypeCubit propertyTypeCubit = MockPropertyTypeCubit();
  initializeDateFormatting();
  setUp(() {
    when(propertyTypeCubit.state)
        .thenAnswer((realInvocation) => PropertyTypeInitial());
    when(propertyTypeCubit.stream)
        .thenAnswer((realInvocation) => Stream.value(PropertyTypeInitial()));
  });
  testWidgets('verify that on press button to show calendar',
      (widgetTester) async {
    const Widget widget = DatePickerView();
    await widgetTester.blocWrapAndPump<PropertyTypeCubit>(
        propertyTypeCubit, widget);
    await widgetTester.tap(find.byType(OutlinedButton));
    await widgetTester.pump();
    expect(find.byType(Dialog), findsOneWidget);
  });
}
