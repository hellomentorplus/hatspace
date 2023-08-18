import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/inspection_detail/inspection_detail_screen.dart';
import 'package:hatspace/features/inspection_detail/widgets/inspection_information_view.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../widget_tester_extension.dart';
import '../add_property/view/widgets/add_rooms_view_test.dart';

void main() {
  setUpAll(() {
    HatSpaceStrings.load(const Locale('en'));
    initializeDateFormatting();
  });
  testWidgets('test ui for widget', (widgetTester) async {
    await mockNetworkImagesFor(
        () => widgetTester.wrapAndPump(const InspectionDetailScreen(id: '123')));
    expect(find.text('Details'), findsOneWidget);
    expect(find.text('Apartment'), findsOneWidget);
    expect(find.text('Green living space in Melbourne'), findsOneWidget);
    expect(find.text('Victoria'), findsOneWidget);
    expect(find.text(r'$4,800'), findsOneWidget);
    expect(find.text('pw'), findsOneWidget);
    expect(find.text('Yolo Tim'), findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
    expect(find.text('09:00 AM'), findsOneWidget);
    expect(find.text('End'), findsOneWidget);
    expect(find.text('10:00 AM'), findsOneWidget);
    expect(find.text('Date'), findsOneWidget);
    expect(find.text('15 Sep, 2023'), findsOneWidget);
    expect(find.text('Notes'), findsOneWidget);
    expect(find.text('My number is 0438825121'), findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) => validateSvgPictureWithAssets(
            widget, 'assets/icons/arrow_calendar_left.svg')),
        findsOneWidget);

    expect(find.byType(InspectionInformationView), findsOneWidget);

    // TODO : Enable later after implemented
    // expect(
    //     find.byWidgetPredicate((widget) =>
    //         validateSvgPictureWithAssets(widget, 'assets/icons/edit.svg')),
    //     findsOneWidget);

    // expect(
    //     find.byWidgetPredicate((widget) =>
    //         validateSvgPictureWithAssets(widget, 'assets/icons/phone.svg')),
    //     findsOneWidget);

    // expect(
    //     find.byWidgetPredicate((widget) =>
    //         validateSvgPictureWithAssets(widget, 'assets/icons/message.svg')),
    //     findsOneWidget);

    // expect(
    //     find.byWidgetPredicate((widget) =>
    //         validateSvgPictureWithAssets(widget, 'assets/icons/delete.svg')),
    //     findsOneWidget);

    // expect(
    //     find.ancestor(
    //         of: find.text('Edit'), matching: find.byType(SecondaryButton)),
    //     findsOneWidget);

    // expect(
    //     find.ancestor(
    //         of: find.byWidgetPredicate((widget) => validateSvgPictureWithAssets(
    //             widget, 'assets/icons/delete.svg')),
    //         matching: find.byType(IconButton)),
    //     findsOneWidget);

    // expect(
    //     find.ancestor(
    //         of: find.byWidgetPredicate((widget) =>
    //             validateSvgPictureWithAssets(widget, 'assets/icons/phone.svg')),
    //         matching: find.byType(RoundButton)),
    //     findsOneWidget);

    // expect(
    //     find.ancestor(
    //         of: find.byWidgetPredicate((widget) => validateSvgPictureWithAssets(
    //             widget, 'assets/icons/message.svg')),
    //         matching: find.byType(RoundButton)),
    //     findsOneWidget);
  });

  testWidgets(
      'Given user is in BookingDetailScreen. '
      'When user tap on BackButton. '
      'Then user will be navigated out of BookingDetailScreen, back to previous screen',
      (widgetTester) async {
    await mockNetworkImagesFor(
        () => widgetTester.wrapAndPump(const InspectionDetailScreen(id: '123')));

    expect(find.byType(InspectionDetailScreen), findsOneWidget);

    final Finder backBtnFinder = find.ancestor(
        of: find.byWidgetPredicate((widget) => validateSvgPictureWithAssets(
            widget, 'assets/icons/arrow_calendar_left.svg')),
        matching: find.byType(IconButton));

    await widgetTester.tap(backBtnFinder);
    await widgetTester.pumpAndSettle();

    expect(find.byType(InspectionDetailScreen), findsNothing);
  });
}
