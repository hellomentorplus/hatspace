import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property_info/view/minimum_rent_view.dart';
import 'package:hatspace/features/add_property_info/view_modal/property_infor_cubit.dart';
import 'package:hatspace/features/add_property_info/view_modal/property_infor_state.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_modal_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../widget_tester_extension.dart';
import 'minimum_rent_period_view_test.mocks.dart';

@GenerateMocks([PropertyInforCubit])
void main() {
  final MockPropertyInforCubit propertyInforCubit = MockPropertyInforCubit();
  setUp(() {
    when(propertyInforCubit.state)
        .thenAnswer((realInvocation) => const PropertyInforInitial());
    when(propertyInforCubit.stream).thenAnswer(
        (realInvocation) => Stream.value(const PropertyInforInitial()));
  });
  testWidgets('test minimum rent period sheet', (widgetTester) async {
    Widget rentView = MinimumRentView();
    await widgetTester.blocWrapAndPump<PropertyInforCubit>(
        propertyInforCubit, rentView);
    await widgetTester.tap(find.byType(HatSpaceDropDownButton));
    await widgetTester.pump();
    expect(find.byType(HsModalView), findsOneWidget);
  });
}
