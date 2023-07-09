import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/features/add_property/view/widgets/select_photo/select_photo_bottom_sheet.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../widget_tester_extension.dart';

void main() async {
  await HatSpaceStrings.load(const Locale('en'));

  test('verify photo tab label', () {
    expect(PhotoTabs.allPhotos.labelDisplay, 'All Photos');
    // TODO verify more tabs
  });

  test('verify photo tab view', () {
    expect(PhotoTabs.allPhotos.tabView, isA<AllPhotosView>());
    // TODO verify more tabs
  });

  testWidgets('verify common layout on select photo', (widgetTester) async {
    const Widget widget = SelectPhotoBottomSheet();

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget));

    expect(find.text('All Photos'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Upload'), findsOneWidget);
  });

  testWidgets('verify layout on All Photo', (widgetTester) async {
    const Widget widget = SelectPhotoBottomSheet();

    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(widget));

    expect(find.byType(GridView), findsOneWidget);

    final GridView gridView = widgetTester.widget(find.byType(GridView));

    expect(gridView.gridDelegate,
        isA<SliverGridDelegateWithFixedCrossAxisCount>());

    // 4 columns grid
    final SliverGridDelegateWithFixedCrossAxisCount delegate =
        gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
    expect(delegate.crossAxisCount, 4);
  });
}
