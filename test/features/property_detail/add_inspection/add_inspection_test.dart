import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/booking/add_inspection_booking_screen.dart';
import 'package:hatspace/features/booking/add_inspection_success_booking_screen.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:network_image_mock/network_image_mock.dart';
import '../../../find_extension.dart';
import '../../../widget_tester_extension.dart';

void main() async {
  HatSpaceStrings.load(const Locale('en'));
  initializeDateFormatting();

  setUpAll(() async {});

  setUp(() {});

  tearDown(() {});

  testWidgets('Verify UI component', (WidgetTester widget) async {
    Widget addInspectionView = AddInspectionBookingScreen();
    await mockNetworkImagesFor(() => widget.wrapAndPump(addInspectionView));
    expect(find.byType(BookedItemCard), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byType(HsDropDownButton), findsWidgets);
    expect(
        find.widgetWithText(PrimaryButton, 'Book Inspection'), findsOneWidget);
  });

  testWidgets(
      'Given user presses close icon'
      'Then close AddInpectionScreen', (widgetTester) async {
    Widget addInspectionView = AddInspectionBookingScreen();
    await mockNetworkImagesFor(
        () => widgetTester.wrapAndPump(addInspectionView));
    IconButton iconBtn = widgetTester.widget(find.byType(IconButton));
    expect(find.byWidget(iconBtn), findsOneWidget);
    await widgetTester.ensureVisible(find.byWidget(iconBtn));
    await widgetTester.tap(find.byType(IconButton), warnIfMissed: true);
    await widgetTester.pumpAndSettle();
    // Navigate to other screen
    expect(find.byType(AddInspectionBookingScreen), findsNothing);
  });

  group('Booking inspection success test cases', () {
    testWidgets('Verify booking inspection success UI ', (widgetTester) async {
      Widget addInspectionSuccessScreen = const AddInspectionSuccessScreen();
      await mockNetworkImagesFor(
          () => widgetTester.wrapAndPump(addInspectionSuccessScreen));
      expect(find.svgPictureWithAssets(Assets.icons.close), findsOneWidget);
      expect(
          find.svgPictureWithAssets(Assets.icons.primaryCheck), findsOneWidget);
      expect(find.text('Congratulations 🎉'), findsOneWidget);
      expect(find.byType(Divider), findsWidgets);
    });

    testWidgets(
        'Verify interaction'
        'Given user tap on close icon'
        'Then close success screen', (widgetTester) async {
      Widget addInspectionSuccessScreen = const AddInspectionSuccessScreen();
      await mockNetworkImagesFor(
          () => widgetTester.wrapAndPump(addInspectionSuccessScreen));
      IconButton iconBtn = widgetTester.widget(find.byType(IconButton));
      expect(find.byWidget(iconBtn), findsOneWidget);
      await widgetTester.ensureVisible(find.byWidget(iconBtn));
      await widgetTester.tap(find.byType(IconButton), warnIfMissed: true);
      await widgetTester.pumpAndSettle();
      // Navigate to other screen
      expect(find.byType(AddInspectionSuccessScreen), findsNothing);
    });
  });
}
