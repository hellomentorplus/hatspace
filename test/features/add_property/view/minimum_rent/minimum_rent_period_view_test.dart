import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property_info/view/add_property_minimum_rent_view.dart';
import 'package:hatspace/features/add_property_info/view_modal/property_infor_cubit.dart';
import 'package:hatspace/features/add_property_info/view_modal/property_infor_state.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../widget_tester_extension.dart';
import 'minimum_rent_period_view_test.mocks.dart';

@GenerateMocks([PropertyInforCubit])
void main() {
  final MockPropertyInforCubit propertyInforCubit = MockPropertyInforCubit();
  setUp(() {
    when(propertyInforCubit.state)
        .thenAnswer((realInvocation) => PropertyInforInitial());
    when(propertyInforCubit.stream)
        .thenAnswer((realInvocation) => Stream.value(PropertyInforInitial()));
  });
  testWidgets('test minimum rent period sheet',
      (WidgetTester widgetTester) async {
    Widget rentView = AddPropertyMinimumView();
    await widgetTester.blocWrapAndPump<PropertyInforCubit>(
        propertyInforCubit, rentView);
    await widgetTester.tap(find.byType(HatSpaceDropDownButton));
    await widgetTester.pump();
    await widgetTester.pump(const Duration(milliseconds: 750));
    expect(find.byKey(const Key('rent_view_modal')), findsWidgets);
  });
}
