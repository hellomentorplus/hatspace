import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_modal_selection_view.dart';

import '../widget_tester_extension.dart';

void main() {
  testWidgets('test minimum rent period sheet',
      (WidgetTester widgetTester) async {
    Widget rentView = HsModalSelectionView(
      itemList: AustraliaStates.values,
      dislayName: (item) => item.displayName,
      selection: ValueNotifier<AustraliaStates>(AustraliaStates.invalid),
      onValueChanges: (value) {},
    );
    await widgetTester.wrapAndPump(rentView);
    await widgetTester.tap(find.byType(HatSpaceDropDownButton));
    await widgetTester.pump();
    expect(find.byType(SizedBox), findsWidgets);
  });
}
