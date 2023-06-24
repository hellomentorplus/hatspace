import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_info_view/minimum_rent_period_view.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import '../../../../widget_tester_extension.dart';

void main() {
  testWidgets('test minimum rent period sheet',
      (WidgetTester widgetTester) async {
    Widget rentView = MinimumRentPeriodView();
    await widgetTester.wrapAndPump(rentView);
    await widgetTester.tap(find.byType(HatSpaceDropDownButton));
    await widgetTester.pump();
    expect(find.byKey(const Key('rent_view_modal')), findsWidgets);
  });
}
