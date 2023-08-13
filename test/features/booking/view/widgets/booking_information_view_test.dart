import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/booking/view/widgets/booking_information_view.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../widget_tester_extension.dart';
import '../../../add_property/view/widgets/add_rooms_view_test.dart';

void main() {
  setUpAll(() {
    HatSpaceStrings.load(const Locale('en'));
    initializeDateFormatting();
  });
  testWidgets('Verify UI', (widgetTester) async {
    await mockNetworkImagesFor(() => widgetTester.wrapAndPump(
        BookingInformationView(
            propertyImageUrl: 'propertyImageUrl.png',
            propertyTitle: 'propertyTitle',
            propertyPrice: 300,
            propertyState: 'propertyState',
            propertySymbol: r'$',
            userAvatar: 'userAvatar.png' ,
            userName: 'ABC',
            type: PropertyTypes.house,
            startTime: DateTime(2023, 8, 12, 1),
            endTime: DateTime(2023, 8, 12, 8),
            notes: 'Here is the note')));
    expect(find.byType(BookingInformationView), findsOneWidget);
    expect(find.text('House'), findsOneWidget);
    expect(find.text('propertyTitle'), findsOneWidget);
    expect(find.text('propertyState'), findsOneWidget);
    expect(find.text(r'$300'), findsOneWidget);
    expect(find.text('pw'), findsOneWidget);
    expect(find.text('ABC'), findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
    expect(find.text('01:00 AM'), findsOneWidget);
    expect(find.text('End'), findsOneWidget);
    expect(find.text('08:00 AM'), findsOneWidget);
    expect(find.text('Date'), findsOneWidget);
    expect(find.text('12 Aug, 2023'), findsOneWidget);
    expect(find.text('Notes'), findsOneWidget);
    expect(find.text('Here is the note'), findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) => verifyContainerNetworkImage(widget, 'propertyImageUrl.png')),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) => verifyContainerNetworkImage(widget, 'userAvatar.png')),
        findsOneWidget);
    
    expect(
        find.byWidgetPredicate(
            (widget) => validateSvgPictureWithAssets(widget, 'assets/icons/phone.svg')),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (widget) => validateSvgPictureWithAssets(widget, 'assets/icons/message.svg')),
        findsOneWidget);
  });
}

bool verifyContainerNetworkImage(Widget widget, String url) {
  if (widget is! Container) {
    return false;
  }

  final DecorationImage? imageProvider =
      (widget.decoration as BoxDecoration).image;
  if (imageProvider == null) {
    return false;
  }

  if (imageProvider.image is! NetworkImage) {
    return false;
  }

  final NetworkImage networkImage = imageProvider.image as NetworkImage;
  return networkImage.url == url;
}
