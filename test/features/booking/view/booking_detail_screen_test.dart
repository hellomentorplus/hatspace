import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/booking/view/booking_detail_screen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../widget_tester_extension.dart';
import '../../add_property/view/widgets/add_rooms_view_test.dart';

void main() {

  setUpAll(() {
    HatSpaceStrings.load(const Locale('en'));
    initializeDateFormatting();
  });
  testWidgets('test ui for widget', (widgetTester) async {
    await mockNetworkImagesFor(
        () => widgetTester.wrapAndPump(const BookingDetailScreen(id: '123')));
    expect(find.text('Details'), findsOneWidget);
    expect(find.text('House'), findsOneWidget);
    expect(find.text('Single room for rent in Bankstown'), findsOneWidget);
    expect(find.text('Gateway, Island'), findsOneWidget);
    expect(find.text(r'$200'), findsOneWidget);
    expect(find.text('pw'), findsOneWidget);
    expect(find.text('Jane Cooper'), findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
    expect(find.text('01:00 AM'), findsOneWidget);
    expect(find.text('End'), findsOneWidget);
    expect(find.text('08:00 AM'), findsOneWidget);
    expect(find.text('Date'), findsOneWidget);
    expect(find.text('12 Aug, 2023'), findsOneWidget);
    expect(find.text('Notes'), findsOneWidget);
    expect(
        find.text(
            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint.'),
        findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(widget, 'assets/icons/phone.svg')),
        findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(widget, 'assets/icons/message.svg')),
        findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(widget, 'assets/icons/delete.svg')),
        findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(widget, 'assets/icons/edit.svg')),
        findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(widget, 'assets/icons/arrow_calendar_left.svg')),
        findsOneWidget);

    expect(find.ancestor(of: find.text('Edit'), matching: find.byType(SecondaryButton)), findsOneWidget);

    expect(find.ancestor(of: find.byWidgetPredicate((widget) => validateSvgPictureWithAssets(
                widget, 'assets/icons/delete.svg')), matching: find.byType(IconButton)), findsOneWidget);

    expect(find.ancestor(of: find.byWidgetPredicate((widget) => validateSvgPictureWithAssets(
                widget, 'assets/icons/phone.svg')), matching: find.byType(RoundButton)), findsOneWidget);

    expect(
        find.ancestor(
            of: find.byWidgetPredicate((widget) =>
                validateSvgPictureWithAssets(widget, 'assets/icons/message.svg')),
            matching: find.byType(RoundButton)),
        findsOneWidget);

  });
}
