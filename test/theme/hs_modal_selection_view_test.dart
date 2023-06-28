import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_modal_selection_view.dart';
import 'package:hatspace/theme/widgets/hs_modal_view.dart';

import '../find_extension.dart';
import '../widget_tester_extension.dart';

void main() {
  testWidgets('Verify hs_modal UI', (WidgetTester widgetTester) async {
    ValueNotifier<AustraliaStates> notifier =
        ValueNotifier(AustraliaStates.invalid);

    Widget rentView = HsModalSelectionView<AustraliaStates>(
      itemList: AustraliaStates.values,
      dislayName: (item) => item.displayName,
      selection: notifier,
      onValueChanges: (selectedState) {
        notifier.value = selectedState;
      },
      label: 'State',
    );
    await widgetTester.wrapAndPump(rentView);
    await widgetTester.tap(find.byType(HatSpaceDropDownButton));
    await widgetTester.pump();
    // Find Hs_modal with label
    expect(find.byType(HsModalView<AustraliaStates>), findsOneWidget);
    expect(find.text('State', skipOffstage: false), findsOneWidget);
    // Find Render item list
    expect(find.byType(HsModalView<AustraliaStates>), findsWidgets);
    for (int i = 0; i < AustraliaStates.values.length; i++) {
      if (AustraliaStates.values[i] != AustraliaStates.invalid) {
        expect(
            find.text(AustraliaStates.values[i].displayName,
                skipOffstage: false),
            findsOneWidget);
      }
    }
    // before tap: find only 2 icon close icon and chervonDown
    expect(
        find.svgPictureWithAssets(Assets.images.chervonDown), findsOneWidget);
    expect(find.svgPictureWithAssets(Assets.images.closeIcon), findsOneWidget);
  });
}
