import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property/view/select_property_type.dart';
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
  testWidgets('verify that SelectPropertyType listent to Property Cubit',
      (widgetTester) async {
    const Widget widget = SelectPropertyType();

    await widgetTester.blocWrapAndPump<PropertyTypeCubit>(
        propertyTypeCubit, widget);
    expect(find.byWidget(widget), findsOneWidget);
    GridView gridView = widgetTester.widget(find.byType(GridView));
    expect(gridView.padding, const EdgeInsets.only(top: 32));
    expect(
        gridView.gridDelegate,
        const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 15));
  });
}
