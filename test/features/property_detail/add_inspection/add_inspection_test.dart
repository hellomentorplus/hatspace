import 'package:clock/clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/booking/add_inspection_booking_screen.dart';
import 'package:hatspace/features/booking/add_inspection_success_booking_screen.dart';
import 'package:hatspace/features/booking/view_model/cubit/add_inspection_booking_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/member_service/property_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_date_picker.dart';
import 'package:hatspace/view_models/authentication/authentication_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import '../../../find_extension.dart';
import '../../../widget_tester_extension.dart';
import '../../add_property/view/widgets/add_rooms_view_test.dart';
import 'add_inspection_test.mocks.dart';

@GenerateMocks([
  StorageService,
  AuthenticationService,
  AddInspectionBookingCubit,
  AuthenticationBloc,
  UserDetail,
  PropertyService,
  MemberService
])
void main() async {
  HatSpaceStrings.load(const Locale('en'));
  initializeDateFormatting();
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockStorageService storageService = MockStorageService();
  final MockAddInspectionBookingCubit addInspectionBookingCubit =
      MockAddInspectionBookingCubit();
  final MockAuthenticationBloc authenticationBloc = MockAuthenticationBloc();
  final MockPropertyService propertyService = MockPropertyService();
  final MockMemberService memberService = MockMemberService();
  final Property property = Property(
      type: PropertyTypes.apartment,
      name: 'property name',
      price: Price(currency: Currency.aud, rentPrice: 100),
      description: 'property description',
      address: const AddressDetail(
        unitNo: '10',
        streetNo: 'streetName',
        streetName: 'streetName',
        state: AustraliaStates.vic,
        postcode: '1234',
        suburb: 'suburb',
      ),
      additionalDetail: AdditionalDetail(
          bathrooms: 1,
          bedrooms: 1,
          parkings: 1,
          additional: Feature.values.map((e) => e.name).toList()),
      photos: ['photo1', 'photo2', 'photo3', 'photo4'],
      minimumRentPeriod: MinimumRentPeriod.sixMonths,
      location: const GeoPoint(1.0, 1.0),
      availableDate: Timestamp.fromDate(DateTime(2023, 10, 22)),
      ownerUid: 'ownerUid');
  setUpAll(() async {
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
    withClock(Clock.fixed(DateTime(2022, 10, 15)), () async {
      HsSingleton.singleton.registerSingleton<Clock>(clock);
    });
  });

  setUp(() {
    when(storageService.member).thenReturn(memberService);
    when(storageService.property).thenReturn(propertyService);
    when(authenticationBloc.state).thenReturn(AuthenticationInitial());
    when(authenticationBloc.stream)
        .thenAnswer((realInvocation) => const Stream.empty());
    when(propertyService.getProperty(any))
        .thenAnswer((realInvocation) => Future.value(property));
    when(memberService.getMemberDisplayName(any))
        .thenAnswer((realInvocation) => Future.value('Owner displayName'));
    when(memberService.getMemberAvatar(any))
        .thenAnswer((realInvocation) => Future.value('photo'));

    when(authenticationService.getCurrentUser())
        .thenAnswer((realInvocation) => Future.value(UserDetail(uid: 'uid')));
  });

  testWidgets('Verify UI component', (WidgetTester widget) async {
    Widget addInspectionView = const AddInspectionBookingScreen(id: 'id');
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
    Widget addInspectionView = const AddInspectionBookingScreen(id: 'id');
    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<AuthenticationBloc>(
            authenticationBloc, addInspectionView));
    IconButton iconBtn = widgetTester.widget(find.byType(IconButton));
    expect(find.byWidget(iconBtn), findsOneWidget);
    await widgetTester.ensureVisible(find.byWidget(iconBtn));
    await widgetTester.tap(find.byType(IconButton), warnIfMissed: true);
    await widgetTester.pumpAndSettle();
    // await mockNetworkImagesFor(
    //   () => widgetTester.pumpAndSettle(const Duration(seconds: 1)));
    // // Navigate to other screen
    // expect(find.byType(AddInspectionBookingScreen), findsNothing);
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
            addInspectionBookingCubit, AddInspectionBookingBody(id: 'id')));
    await widgetTester.pumpAndSettle();

    expect(find.byType(AddInspectionBookingBody), findsOneWidget);

    final Finder bookingBtnFinder = find.byType(PrimaryButton);

    expect(bookingBtnFinder, findsOneWidget);

    await widgetTester.ensureVisible(bookingBtnFinder);
    await widgetTester.tap(bookingBtnFinder);
    await widgetTester.pumpAndSettle();

    verify(addInspectionBookingCubit.onBookInspection()).called(1);
  });

  testWidgets(
      'Given user is in AddInspectionBookingScreen. '
      'When user tap on the date picker. '
      'Then the date picker ui will be shown up.', (widgetTester) async {
    when(addInspectionBookingCubit.stream)
        .thenAnswer((_) => Stream.value(AddInspectionBookingInitial()));
    when(addInspectionBookingCubit.state)
        .thenAnswer((_) => AddInspectionBookingInitial());

    await mockNetworkImagesFor(
        () => widgetTester.blocWrapAndPump<AddInspectionBookingCubit>(
            addInspectionBookingCubit,
            AddInspectionBookingBody(
              id: 'id',
            )));
    await widgetTester.pumpAndSettle();

    expect(find.byType(AddInspectionBookingBody), findsOneWidget);

    final Finder datePickerFinder = find.ancestor(
        of: find.byWidgetPredicate((widget) =>
            validateSvgPictureWithAssets(widget, 'assets/icons/calendar.svg')),
        matching: find.byType(SecondaryButton));

    expect(datePickerFinder, findsOneWidget);

    await widgetTester.ensureVisible(datePickerFinder);
    await widgetTester.tap(datePickerFinder);
    await widgetTester.pumpAndSettle();

    expect(find.byType(HsDatePicker), findsOneWidget);
  });

  testWidgets(
      'Given user is in AddInspectionBookingScreen. '
      'When booking action was succeed. '
      'Then user will be navigated out of AddInspectionBookingScreen',
      (widgetTester) async {
    when(addInspectionBookingCubit.stream)
        .thenAnswer((_) => Stream.value(BookingInspectionSuccess()));
    when(addInspectionBookingCubit.state)
        .thenAnswer((_) => BookingInspectionSuccess());

    await mockNetworkImagesFor(
        () => widgetTester.blocWrapAndPump<AddInspectionBookingCubit>(
            addInspectionBookingCubit,
            AddInspectionBookingBody(
              id: 'id',
            )));
    await widgetTester.pumpAndSettle();

    expect(find.byType(AddInspectionBookingBody), findsNothing);
    expect(find.byType(AddInspectionSuccessScreen), findsOneWidget);
  });

  group('Booking inspection success test cases', () {
    testWidgets('Verify booking inspection success UI ', (widgetTester) async {
      Widget addInspectionSuccessScreen = const AddInspectionSuccessScreen(
        id: 'id',
      );
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
      Widget addInspectionSuccessScreen = const AddInspectionSuccessScreen(
        id: 'id',
      );
      await mockNetworkImagesFor(() =>
          widgetTester.blocWrapAndPump<AuthenticationBloc>(
              authenticationBloc, addInspectionSuccessScreen));
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
