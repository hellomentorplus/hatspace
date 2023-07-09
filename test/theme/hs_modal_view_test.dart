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

    // verify interaction on WA
    await widgetTester.tap(find.text('Western Australia', skipOffstage: false));
    await widgetTester.pumpAndSettle();
    expect(modalView.modalNotifier.value, AustraliaStates.wa);
    expect(find.svgPictureWithAssets(Assets.images.check), findsOneWidget);

    // verify interaction on qld
    await widgetTester.tap(find.text('Queensland', skipOffstage: false));
    await widgetTester.pumpAndSettle();
    expect(modalView.modalNotifier.value, AustraliaStates.qld);
    expect(find.svgPictureWithAssets(Assets.images.check), findsOneWidget);

    // verify interaction on sa
    await widgetTester.tap(find.text('South Australia', skipOffstage: false));
    await widgetTester.pumpAndSettle();
    expect(modalView.modalNotifier.value, AustraliaStates.sa);
    expect(find.svgPictureWithAssets(Assets.images.check), findsOneWidget);

    // verify interaction on nsw tap
    await widgetTester.tap(find.text('New South Wales', skipOffstage: false));
    await widgetTester.pumpAndSettle();
    expect(modalView.modalNotifier.value, AustraliaStates.nsw);
    expect(find.svgPictureWithAssets(Assets.images.check), findsOneWidget);

    // verify interaction on vic
    await widgetTester.tap(find.text('Victoria', skipOffstage: false));
    await widgetTester.pumpAndSettle();
    expect(modalView.modalNotifier.value, AustraliaStates.vic);
    expect(find.svgPictureWithAssets(Assets.images.check), findsOneWidget);

    // verify interaction on tasmaina
    await widgetTester.tap(find.text('Tasmania', skipOffstage: false));
    await widgetTester.pumpAndSettle();
    expect(modalView.modalNotifier.value, AustraliaStates.tas);
    expect(find.svgPictureWithAssets(Assets.images.check), findsOneWidget);

    // verify interaction on Australian Capital Territory
    await widgetTester.dragUntilVisible(
        find.text('Australian Capital Territory'),
        find.byType(ListView),
        const Offset(0.0, -300));
    await widgetTester.tap(find.text('Australian Capital Territory'));
    await widgetTester.pumpAndSettle();
    expect(modalView.modalNotifier.value, AustraliaStates.act);
    expect(find.svgPictureWithAssets(Assets.images.check), findsOneWidget);
  });
  // due to
}
