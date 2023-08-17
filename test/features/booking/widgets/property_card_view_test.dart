import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/booking/widgets/property_card_view.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../widget_tester_extension.dart';
import 'booking_information_view_test.dart';

void main() {
  testWidgets('Verify UI', (widgetTester) async {
    await mockNetworkImagesFor(
        () => widgetTester.wrapAndPump(const PropertyCardView(
              imageUrl: 'propertyImageUrl.png',
              type: PropertyTypes.house,
              title: 'propertyTitle',
              state: 'propertyState',
              price: 300,
              symbol: r'$',
            )));
    expect(find.text('House'), findsOneWidget);
    expect(find.text('propertyTitle'), findsOneWidget);
    expect(find.text('propertyState'), findsOneWidget);
    expect(find.text(r'$300'), findsOneWidget);
    expect(find.text('pw'), findsOneWidget);

    expect(
        find.byWidgetPredicate((widget) =>
            verifyContainerNetworkImage(widget, 'propertyImageUrl.png')),
        findsOneWidget);
  });
}
