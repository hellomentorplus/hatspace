import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/inspection_confirmation_list/inspection_confirmation_list_screen.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../widget_tester_extension.dart';

void main() {
  testWidgets('verify UI', (widgetTester) async {
    await mockNetworkImagesFor(() => widgetTester
        .wrapAndPump(const InspectionConfirmationListScreen(id: '123')));

    expect(find.text('1 inspection booking'), findsOneWidget);
    expect(find.byType(BookingInformationItem), findsNWidgets(1));
  });
}
