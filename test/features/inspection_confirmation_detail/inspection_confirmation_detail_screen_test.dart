import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/inspection/inspection_view.dart';
import 'package:hatspace/features/inspection_confirmation_detail/inspection_confirmation_detail_screen.dart';
import 'package:hatspace/features/inspection_detail/inspection_detail_screen.dart';
import 'package:hatspace/features/inspection_detail/widgets/inspection_information_view.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../widget_tester_extension.dart';

void main() {
  setUpAll(() {
    HatSpaceStrings.load(const Locale('en'));
    initializeDateFormatting();
  });
  testWidgets('Verify UI', (widgetTester) async {
    await mockNetworkImagesFor(() => widgetTester
        .wrapAndPump(const InspectionConfirmationDetailScreen(id: 'id')));
    expect(find.text('Details'), findsOneWidget);
    expect(find.text('Apartment'), findsOneWidget);
    expect(find.text('Green living space in Melbourne'), findsOneWidget);
    expect(find.text('Victoria'), findsOneWidget);
    expect(find.text(r'$4,800'), findsOneWidget);
    expect(find.text('pw'), findsOneWidget);
    expect(find.text('Captain Cole'), findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
    expect(find.text('09:00 AM'), findsOneWidget);
    expect(find.text('End'), findsOneWidget);
    expect(find.text('10:00 AM'), findsOneWidget);
    expect(find.text('Date'), findsOneWidget);
    expect(find.text('15 Sep, 2023'), findsOneWidget);
    expect(find.text('Notes'), findsOneWidget);
    expect(find.text(''), findsOneWidget);

    expect(find.byType(InspectionInformationView), findsOneWidget);

    expect(find.byType(HsBackButton), findsOneWidget);

    expect(find.byType(InspectionInformationView), findsOneWidget);
  });

  testWidgets(
      'Given user is in BookingDetailScreen for homeowner. '
      'When user tap on BackButton. '
      'Then user will be navigated out of BookingDetailScreen, back to previous screen which is InspectionScreen',
      (widgetTester) async {
    await mockNetworkImagesFor(() =>
        widgetTester.wrapAndPump(const InspectionDetailScreen(id: '123')));

    expect(find.byType(InspectionDetailScreen), findsOneWidget);

    await widgetTester.tap(find.byType(HsBackButton));
    await widgetTester.pumpAndSettle();

    expect(find.byType(InspectionDetailScreen), findsNothing);
  });
}
