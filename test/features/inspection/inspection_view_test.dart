import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/inspection/inspection_view.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../widget_tester_extension.dart';

void main() {
  testWidgets('verify UI', (widgetTester) async {
    await mockNetworkImagesFor(
        () => widgetTester.wrapAndPump(const InspectionView()));

    expect(find.text('Inspection Booking'), findsOneWidget);
    expect(find.text('3 inspect booking'), findsOneWidget);
    expect(find.byType(TenantBookItemView), findsNWidgets(3));
    // skip check dummy data, will update when getting real data
  });
}
