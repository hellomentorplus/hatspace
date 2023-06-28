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
  testWidgets('Verify hs modal UI', (WidgetTester widgetTester) async {
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
    // find drop down button
    expect(find.byType(HsDropDownButton), findsOneWidget);
    expect(find.svgPictureWithAssets(Assets.images.chervonDown), findsOneWidget);
    await widgetTester.tap(find.byType(HsDropDownButton));
    await widgetTester.pump();
    // Find Hs_modal with label
    expect(find.byType(HsModalView<AustraliaStates>), findsOneWidget);
    // before tap: find only 2 icon close icon and chervonDown
  });
}
