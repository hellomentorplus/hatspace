import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_info_view/add_property_state_view.dart';

import 'package:hatspace/theme/widgets/hs_buttons.dart';

import '../../../../widget_tester_extension.dart';

void main() {
  testWidgets('test state bottom sheet for widget', (widgetTester) async {
    Widget stateView = AddPropertyStateView();
    await widgetTester.wrapAndPump(stateView);
    await widgetTester.tap(find.byType(HatSpaceDropDownButton));
    await widgetTester.pump();
    expect(find.byKey(const Key('state_view_modal')), findsWidgets);
  });
}
