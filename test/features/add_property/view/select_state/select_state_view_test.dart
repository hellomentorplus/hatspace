import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property_info/view/property_info_form.dart';
import 'package:hatspace/features/add_property_info/view/state_selection_view.dart';
import 'package:hatspace/features/add_property_info/view_modal/property_infor_cubit.dart';
import 'package:hatspace/features/add_property_info/view_modal/property_infor_state.dart';
import 'package:hatspace/theme/widgets/hs_modal_view.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../widget_tester_extension.dart';
import 'select_state_view_test.mocks.dart';

@GenerateMocks([PropertyInforCubit])
void main() {
  final MockPropertyInforCubit propertyInforCubit = MockPropertyInforCubit();
  // initializeDateFormatting();
  setUp(() {
    when(propertyInforCubit.state)
        .thenAnswer((realInvocation) => const PropertyInforInitial());
    when(propertyInforCubit.stream).thenAnswer(
        (realInvocation) => Stream.value(const PropertyInforInitial()));
  });
  testWidgets('test state bottom sheet for widget', (widgetTester) async {
    Widget stateView = StateSelectionView();
    await widgetTester.blocWrapAndPump<PropertyInforCubit>(
        propertyInforCubit, stateView);
    await widgetTester.tap(find.byType(HatSpaceDropDownButton));
    await widgetTester.pump();
    expect(find.byType(HsModalView), findsOneWidget);
  });
}
