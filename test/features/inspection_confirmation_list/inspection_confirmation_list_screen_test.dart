import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/inspection_confirmation_list/inspection_confirmation_list_screen.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../find_extension.dart';
import '../../widget_tester_extension.dart';

void main() {
  testWidgets('verify UI', (widgetTester) async {
    await mockNetworkImagesFor(() => widgetTester
        .wrapAndPump(const InspectionConfirmationListScreen(id: '123')));

    expect(find.text('1 inspection booking'), findsOneWidget);
    expect(find.byType(BookingInformationItem), findsNWidgets(1));
  });

  testWidgets(
      'given user is on InspectionConfirmationListScreen, when user taps back button, then exit the screen',
      (widgetTester) async {
    await mockNetworkImagesFor(() => widgetTester
        .wrapAndPump(const InspectionConfirmationListScreen(id: '123')));

    expect(find.text('1 inspection booking'), findsOneWidget);
    expect(find.byType(BookingInformationItem), findsNWidgets(1));

    await widgetTester
        .tap(find.svgPictureWithAssets('assets/icons/arrow_calendar_left.svg'));
    await widgetTester.pumpAndSettle();

    expect(find.byType(InspectionConfirmationListScreen), findsNothing);
  });
}
