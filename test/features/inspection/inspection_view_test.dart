import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/inspection/inspection_view.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../widget_tester_extension.dart';

void main() {
  setUpAll(() {
    HatSpaceStrings.load(const Locale('en'));
    initializeDateFormatting();
  });
  testWidgets('verify UI', (widgetTester) async {
    await mockNetworkImagesFor(
        () => widgetTester.wrapAndPump(const InspectionView()));

    expect(find.text('Inspection Booking'), findsOneWidget);
    expect(find.text('3 inspect booking'), findsOneWidget);
    expect(find.byType(TenantBookItemView), findsNWidgets(3));
    // skip check dummy data, will update when getting real data
  });

  testWidgets('verify interaction', (widgetTester) async {
    await mockNetworkImagesFor(
        () => widgetTester.wrapAndPump(const InspectionView()));

    expect(find.byType(InspectionView), findsOneWidget);
    final Finder bookItemsFinder = find.byType(TenantBookItemView);
    expect(bookItemsFinder, findsWidgets);

    await widgetTester.ensureVisible(bookItemsFinder.first);
    await widgetTester.tap(bookItemsFinder.first);
    await widgetTester.pumpAndSettle();

    expect(find.byType(InspectionView), findsNothing);
  });
}
