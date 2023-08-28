import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/booking/add_inspection_booking_screen.dart';
import 'package:hatspace/features/booking/add_inspection_success_booking_screen.dart';
import 'package:hatspace/features/booking/view_model/cubit/add_inspection_booking_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_date_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import '../../../find_extension.dart';
import '../../../widget_tester_extension.dart';
import '../../add_property/view/widgets/add_rooms_view_test.dart';
import 'add_inspection_test.mocks.dart';

@GenerateMocks(
    [StorageService, AuthenticationService, AddInspectionBookingCubit])
void main() async {
  HatSpaceStrings.load(const Locale('en'));
  initializeDateFormatting();
  final MockAuthenticationService authenticationServiceMock =
      MockAuthenticationService();
  final MockStorageService storageServiceMock = MockStorageService();
  final MockAddInspectionBookingCubit addInspectionBookingCubit =
      MockAddInspectionBookingCubit();

  setUpAll(() async {
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationServiceMock);
    HsSingleton.singleton.registerSingleton<StorageService>(storageServiceMock);
  });

  testWidgets('Verify UI component', (WidgetTester widget) async {
    Widget addInspectionView = const AddInspectionBookingScreen();
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
    Widget addInspectionView = const AddInspectionBookingScreen();
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

  testWidgets(
      'Given user is in AddInspectionBookingScreen. '
      'When user tap on booking button. '
      'Then user will start booking process.', (widgetTester) async {
    when(addInspectionBookingCubit.stream)
        .thenAnswer((_) => Stream.value(AddInspectionBookingInitial()));
    when(addInspectionBookingCubit.state)
        .thenAnswer((_) => AddInspectionBookingInitial());

    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<AddInspectionBookingCubit>(
            addInspectionBookingCubit, AddInspectionBookingBody()));
    await widgetTester.pumpAndSettle();

    expect(find.byType(AddInspectionBookingBody), findsOneWidget);

    final Finder bookingBtnFinder = find.byType(PrimaryButton);

    expect(bookingBtnFinder, findsOneWidget);

    await widgetTester.ensureVisible(bookingBtnFinder);
    await widgetTester.tap(bookingBtnFinder);
    await widgetTester.pumpAndSettle();

    verify(addInspectionBookingCubit.onBookInspection()).called(1);
  });

  // testWidgets(
  //     'Given user is in AddInspectionBookingScreen. '
  //     'When user tap on booking button. '
  //     'Then user will start booking process.', (widgetTester) async {
  //   when(addInspectionBookingCubit.stream)
  //       .thenAnswer((_) => Stream.value(AddInspectionBookingInitial()));
  //   when(addInspectionBookingCubit.state)
  //       .thenAnswer((_) => AddInspectionBookingInitial());

  //   await mockNetworkImagesFor(() =>
  //       widgetTester.blocWrapAndPump<AddInspectionBookingCubit>(
  //           addInspectionBookingCubit, AddInspectionBookingBody()));
  //   await widgetTester.pumpAndSettle();

  //   expect(find.byType(AddInspectionBookingBody), findsOneWidget);

  //   final Finder datePickerFinder = find.ancestor(of: find.byWidgetPredicate((widget) =>
  //           validateSvgPictureWithAssets(widget, 'assets/icons/calendar.svg')), matching: find.byType(SecondaryButton));

  //   expect(datePickerFinder, findsOneWidget);

  //   await widgetTester.ensureVisible(datePickerFinder);
  //   await widgetTester.tap(datePickerFinder);
  //   await widgetTester.pumpAndSettle();

  //   expect(find.byType(HsDatePicker), findsOneWidget);

  // });

  testWidgets(
      'Given user is in AddInspectionBookingScreen. '
      'When booking action was succeed. '
      'Then user will be navigated out of AddInspectionBookingScreen',
      (widgetTester) async {
    when(addInspectionBookingCubit.stream)
        .thenAnswer((_) => Stream.value(BookingInspectionSuccess()));
    when(addInspectionBookingCubit.state)
        .thenAnswer((_) => BookingInspectionSuccess());

    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<AddInspectionBookingCubit>(
            addInspectionBookingCubit, AddInspectionBookingBody()));
    await widgetTester.pumpAndSettle();

    expect(find.byType(AddInspectionBookingBody), findsNothing);
    expect(find.byType(AddInspectionSuccessScreen), findsOneWidget);
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
