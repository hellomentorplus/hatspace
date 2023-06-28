import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/widgets/hs_modal_view.dart';

import '../find_extension.dart';
import '../widget_tester_extension.dart';

void main() {
  testWidgets('Verify modal view with interaction', (widgetTester) async {
    List<AustraliaStates> itemList = AustraliaStates.values.toList();
    itemList.removeWhere((value) => value == AustraliaStates.invalid);
    ValueNotifier selectionNotifier = ValueNotifier(AustraliaStates.invalid);
    HsModalView<AustraliaStates> modalView = HsModalView<AustraliaStates>(
        selection: selectionNotifier.value,
        title: 'State',
        getItemString: (state) => state.displayName,
        itemList: itemList,
        onSave: (selectedValue) {
          selectionNotifier.value = selectedValue;
        });

    await widgetTester.wrapAndPump(modalView);
    // verify title
    expect(find.text('State'), findsOneWidget);
    // verify close icon
    expect(find.svgPictureWithAssets(Assets.images.closeIcon), findsOneWidget);
    Positioned positioned = widgetTester.widget(find.byType(Positioned));
    expect(positioned.right, HsDimens.spacing24);
    // verify interaction on nsw tap
    await widgetTester
        .tap(find.text(AustraliaStates.nsw.displayName, skipOffstage: false));
    await widgetTester.pumpAndSettle();
    expect(modalView.modalNotifier.value, AustraliaStates.nsw);
    expect(find.svgPictureWithAssets(Assets.images.check), findsOneWidget);

    // verify check icon must have only one when trigger another tap
    await widgetTester
        .tap(find.text(AustraliaStates.vic.displayName, skipOffstage: false));
    await widgetTester.pumpAndSettle();
    expect(find.svgPictureWithAssets(Assets.images.check), findsOneWidget);
  });
  // due to
}
