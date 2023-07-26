import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_preview_view.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:network_image_mock/network_image_mock.dart';
import '../../../../widget_tester_extension.dart';

void main() {
  initializeDateFormatting();
  HatSpaceStrings.load(const Locale('en'));

  testWidgets(
      'Given user has inputted property information.'
      'When user go to Preview screen.'
      'User will see all information they have inputted before.',
      (WidgetTester widgetTester) async {
    await mockNetworkImagesFor(
        () => widgetTester.wrapAndPump(const AddPropertyPreviewView()));
    expect(find.text('House'), findsOneWidget);
    expect(
        find.text('Available: 06/06/23', findRichText: true), findsOneWidget);
    expect(find.text('Single room for rent in Bankstown'), findsOneWidget);
    expect(find.text('Gateway, Island'), findsOneWidget);
    expect(find.text(r'$30,000 pw', findRichText: true), findsOneWidget);
    expect(find.text('Jane Cooper'), findsOneWidget);
    expect(
        find.text(
            'This updated cottage has much to offer with:- Polished floorboards in living areas and carpeted bedrooms- New modern kitchen with dishwasher, gas burner stove top and plenty of storage- Dining area- Lounge room- Study/Home office space- 2 Bedrooms- Lovely bathroom- Separate laundry.'),
        findsOneWidget);
    expect(find.text('Location'), findsOneWidget);
    expect(
        find.text(
            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim'),
        findsOneWidget);
    expect(find.text('Property features'), findsOneWidget);
    for (Feature feat in Feature.values) {
      expect(find.text(feat.displayName), findsOneWidget);
    }
  });
}
