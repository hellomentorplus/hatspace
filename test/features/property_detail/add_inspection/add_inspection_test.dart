import 'package:clock/clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/booking/add_inspection_booking_screen.dart';
import 'package:hatspace/features/booking/add_inspection_success_booking_screen.dart';
import 'package:hatspace/features/booking/view_model/cubit/add_inspection_booking_cubit.dart';
import 'package:hatspace/features/booking/widgets/duration_selection_widget.dart';
import 'package:hatspace/features/booking/widgets/start_time_selection_widget.dart';
import 'package:hatspace/features/booking/widgets/update_phone_no_bottom_sheet_view.dart';
import 'package:hatspace/features/inspection/viewmodel/inspection_cubit.dart';
import 'package:hatspace/features/profile/my_profile/view_model/my_profile_cubit.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/inspection_storage_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/member_service/property_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_date_picker.dart';
import 'package:hatspace/view_models/authentication/authentication_bloc.dart';
import 'package:hatspace/view_models/property/property_detail_cubit.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
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
  MemberService,
  PropertyDetailCubit,
  MyProfileCubit,
  InspectionCubit,
  InpsectionService
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
  final MockMyProfileCubit mockMyProfileCubit = MockMyProfileCubit();
  final MockInspectionCubit mockInspectionCubit = MockInspectionCubit();
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
  final MockPropertyDetailCubit propertyDetailCubit = MockPropertyDetailCubit();
  final List<BlocProvider> providers = [
    BlocProvider<AddInspectionBookingCubit>(
        create: (context) => addInspectionBookingCubit),
    BlocProvider<PropertyDetailCubit>(create: (context) => propertyDetailCubit),
    BlocProvider<MyProfileCubit>(create: (context) => mockMyProfileCubit),
  ];
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
    when(propertyDetailCubit.state).thenReturn(PropertyDetailInitial());
    when(propertyDetailCubit.stream)
        .thenAnswer((realInvocation) => const Stream.empty());
    when(addInspectionBookingCubit.isStartTimeSelected).thenReturn(false);
    when(mockMyProfileCubit.state).thenReturn(const MyProfileInitialState());
    when(mockMyProfileCubit.stream)
        .thenAnswer((realInvocation) => const Stream.empty());
    when(mockInspectionCubit.state).thenReturn(InspectionInitial());
    when(mockInspectionCubit.stream)
        .thenAnswer((realInvocation) => const Stream.empty());
  });

  testWidgets('Verify UI component', (WidgetTester widget) async {
    Widget addInspectionView = const AddInspectionBookingScreen(id: 'id');
    await mockNetworkImagesFor(() => widget.wrapAndPump(addInspectionView));
    expect(find.byType(BookedItemCard), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byType(HsDropDownButton), findsWidgets);
    expect(
        find.widgetWithText(PrimaryButton, 'Book Inspection'), findsOneWidget);
    // check character counter of notes
    expect(find.byType(ValueListenableBuilder<int>), findsOneWidget);
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
      'Given user is in AddInspectionBookingScreen.'
      'Given Book Inspection Enabled'
      'When user tap on booking button.'
      'Then user will start booking process.', (widgetTester) async {
    when(addInspectionBookingCubit.stream)
        .thenAnswer((_) => Stream.value(BookInspectionButtonEnable()));
    when(addInspectionBookingCubit.state)
        .thenAnswer((_) => BookInspectionButtonEnable());
    when(addInspectionBookingCubit.duration).thenReturn(15);

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
        providers, const AddInspectionBookingBody(id: 'id')));
    await widgetTester.pumpAndSettle();

    expect(find.byType(AddInspectionBookingBody), findsOneWidget);

    final Finder bookingBtnFinder = find.byType(PrimaryButton);

    expect(bookingBtnFinder, findsOneWidget);

    await widgetTester.ensureVisible(bookingBtnFinder);
    await widgetTester.tap(bookingBtnFinder);
    await widgetTester.pumpAndSettle();

    verify(addInspectionBookingCubit.onBookInspection('id')).called(1);
  });

  testWidgets(
      'Given user is in AddInspectionBookingScreen.'
      'Given start time and duration has not been selected'
      'Then Book Inspection Button is DISABLE', (widgetTester) async {
    when(addInspectionBookingCubit.stream)
        .thenAnswer((_) => Stream.value(AddInspectionBookingInitial()));
    when(addInspectionBookingCubit.state)
        .thenAnswer((_) => AddInspectionBookingInitial());
    when(addInspectionBookingCubit.duration).thenReturn(null);
    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
        providers, const AddInspectionBookingBody(id: 'id')));
    await widgetTester.pumpAndSettle();

    expect(find.byType(AddInspectionBookingBody), findsOneWidget);

    final Finder bookingBtnFinder =
        find.widgetWithText(PrimaryButton, 'Book Inspection');
    PrimaryButton bookingBtn = widgetTester.widget(bookingBtnFinder);
    expect(bookingBtn.onPressed, null);
    expect(bookingBtn.style?.backgroundColor, null);
  });
  testWidgets(
      'Given user is in AddInspectionBookingScreen. '
      'When user tap on the date picker. '
      'Then the date picker ui will be shown up.', (widgetTester) async {
    when(addInspectionBookingCubit.stream)
        .thenAnswer((_) => Stream.value(AddInspectionBookingInitial()));
    when(addInspectionBookingCubit.state)
        .thenAnswer((_) => AddInspectionBookingInitial());
    when(addInspectionBookingCubit.duration).thenReturn(null);

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
        providers, const AddInspectionBookingBody(id: 'id')));
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

  group('Add inspection set start time group', () {
    testWidgets(
        'Given user is in AddInspectionBookingScreen'
        'When user tap on start time drop down menu'
        'Then Show bottom sheet modal with start time', (widgetTester) async {
      when(addInspectionBookingCubit.stream)
          .thenAnswer((_) => Stream.value(AddInspectionBookingInitial()));
      when(addInspectionBookingCubit.state)
          .thenAnswer((_) => AddInspectionBookingInitial());
      when(addInspectionBookingCubit.duration).thenReturn(null);
      when(addInspectionBookingCubit.selectStartTime()).thenReturn(null);
      await mockNetworkImagesFor(() => (widgetTester.multiBlocWrapAndPump(
          providers, const AddInspectionBookingBody(id: 'id'))));
      await widgetTester.pumpAndSettle();

      expect(find.byType(AddInspectionBookingBody), findsOneWidget);

      //find start time with default placeholder
      // Finder startTimeBtn = find.widgetWithText(SecondaryButton, '09:00 AM');
      Finder startTimeBtn = find.byType(StartTimeSelectionWidget);
      expect(startTimeBtn, findsOneWidget);
      await widgetTester.ensureVisible(startTimeBtn);
      await widgetTester.tap(startTimeBtn);
      await widgetTester.pumpAndSettle();
      verify(addInspectionBookingCubit.selectStartTime()).called(1);
    });

    testWidgets(
        'Given user is in Select Start Time Bottom Modal'
        'When user select hour and minute'
        'When user tap save on the bottom modal'
        'Then save inspection date', (widgetTester) async {
      when(addInspectionBookingCubit.stream)
          .thenAnswer((_) => Stream.value(ShowStartTimeSelection()));
      when(addInspectionBookingCubit.state)
          .thenAnswer((_) => ShowStartTimeSelection());
      when(addInspectionBookingCubit.duration).thenReturn(null);
      when(addInspectionBookingCubit.inspectionStartTime)
          .thenReturn(DateTime(2022, 9, 9, 9, 9));
      when(addInspectionBookingCubit.closeBottomModal()).thenReturn(null);
      await mockNetworkImagesFor(() => (widgetTester.multiBlocWrapAndPump(
          providers, const AddInspectionBookingBody(id: 'id'))));
      await widgetTester.pumpAndSettle();
      expect(find.byType(StartTimeSelectionWidget), findsOneWidget);
      Finder saveButton = find.widgetWithText(PrimaryButton, 'Save');
      expect(saveButton, findsOneWidget);
      await widgetTester.ensureVisible(saveButton);
      await widgetTester.tap(saveButton);
      await widgetTester.pumpAndSettle();
      verify(addInspectionBookingCubit.inspectionStartTime).called(1);
    });

    testWidgets(
        'Given user is has not select start time'
        'when user tap on duration'
        'Then show error below Start time', (widgetTester) async {
      when(addInspectionBookingCubit.stream)
          .thenAnswer((_) => Stream.value(RequestStartTimeSelection()));
      when(addInspectionBookingCubit.state)
          .thenAnswer((_) => AddInspectionBookingInitial());
      when(addInspectionBookingCubit.duration).thenReturn(15);

      await mockNetworkImagesFor(() => (widgetTester.multiBlocWrapAndPump(
          providers, const AddInspectionBookingBody(id: 'id'))));
      await widgetTester.pumpAndSettle();
      Finder durationBtn = find.widgetWithText(SecondaryButton, '15 mins');
      expect(durationBtn, findsOneWidget);
      await widgetTester.ensureVisible(durationBtn);
      await widgetTester.tap(durationBtn);
      await widgetTester.pumpAndSettle();
      //Error show when start time has not been selected
      expect(find.text('Select start time'), findsOneWidget);
    });
  });

  group('Add inspection set duration group', () {
    testWidgets(
        'Given user already selected start time'
        'when user tap on duration'
        'Then show select duration bottom sheet', (widgetTester) async {
      when(addInspectionBookingCubit.stream)
          .thenAnswer((_) => Stream.value(AddInspectionBookingInitial()));
      when(addInspectionBookingCubit.state)
          .thenAnswer((_) => AddInspectionBookingInitial());
      when(addInspectionBookingCubit.duration).thenReturn(15);

      await mockNetworkImagesFor(() => (widgetTester.multiBlocWrapAndPump(
          providers, const AddInspectionBookingBody(id: 'id'))));
      await widgetTester.pumpAndSettle();
      Finder durationBtn = find.widgetWithText(SecondaryButton, '15 mins');
      expect(durationBtn, findsOneWidget);
      await widgetTester.ensureVisible(durationBtn);
      await widgetTester.tap(durationBtn);
      await widgetTester.pumpAndSettle();
      //Error show when start time has not been selected
      expect(find.byType(DurationSelectionWidget), findsOneWidget);
    });
    testWidgets(
        'Given user is in Select Start Time Bottom Modal'
        'When user select hour and minute'
        'When user tap save on the bottom modal'
        'Then save inspection date', (widgetTester) async {
      when(addInspectionBookingCubit.stream)
          .thenAnswer((_) => Stream.value(const ShowDurationSelection(true)));
      when(addInspectionBookingCubit.state)
          .thenAnswer((_) => const ShowDurationSelection(true));
      when(addInspectionBookingCubit.duration).thenReturn(null);
      await mockNetworkImagesFor(() => (widgetTester.multiBlocWrapAndPump(
          providers, const AddInspectionBookingBody(id: 'id'))));
      await widgetTester.pumpAndSettle();
      expect(find.byType(DurationSelectionWidget), findsOneWidget);
    });
  });

  testWidgets(
      'Given user is in AddInspectionBookingScreen. '
      'When booking action was succeed. '
      'Then user will be navigated out of AddInspectionBookingScreen',
      (widgetTester) async {
    when(addInspectionBookingCubit.stream).thenAnswer((_) =>
        Stream.value(const BookingInspectionSuccess(inspectionId: 'iId')));
    when(addInspectionBookingCubit.state)
        .thenAnswer((_) => const BookingInspectionSuccess(inspectionId: 'iId'));

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
        providers, const AddInspectionBookingBody(id: 'id')));
    await widgetTester.pumpAndSettle();

    expect(find.byType(AddInspectionBookingBody), findsNothing);
    expect(find.byType(AddInspectionSuccessScreen), findsOneWidget);
  });
  group('Update Profile Modal', () {
    testWidgets(
        'Given state is ShowUpdateProfileModal'
        'Then Update Profile modal will display', (widgetTester) async {
      when(addInspectionBookingCubit.stream)
          .thenAnswer((_) => Stream.value(ShowUpdateProfileModal()));
      when(addInspectionBookingCubit.state)
          .thenAnswer((_) => ShowUpdateProfileModal());
      when(addInspectionBookingCubit.duration).thenReturn(15);
      //when(addInspectionBookingCubit.phoneNo).thenReturn(null);

      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
          providers, const AddInspectionBookingBody(id: 'id')));
      await widgetTester.pumpAndSettle();
      expect(find.byType(AddInspectionBookingBody), findsOneWidget);
      expect(find.byType(UpdatePhoneNoBottomSheetView), findsOneWidget);
    });
    testWidgets(
        'Given state is ShowUpdateProfileModal'
        'When user tap out'
        'Then dismiss UpdateProfile modal ', (widgetTester) async {
      when(addInspectionBookingCubit.stream)
          .thenAnswer((_) => Stream.value(ShowUpdateProfileModal()));
      when(addInspectionBookingCubit.state)
          .thenAnswer((_) => ShowUpdateProfileModal());
      when(addInspectionBookingCubit.duration).thenReturn(15);
      // when(addInspectionBookingCubit.phoneNo).thenReturn(null);
      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
          providers, const AddInspectionBookingBody(id: 'id')));
      await widgetTester.pumpAndSettle();
      expect(find.byType(AddInspectionBookingBody), findsOneWidget);
      expect(find.byType(UpdatePhoneNoBottomSheetView), findsOneWidget);

      // tap out
      await widgetTester.tapAt(const Offset(1, 2));
      await widgetTester.pumpAndSettle();
      expect(find.byType(UpdatePhoneNoBottomSheetView), findsNothing);
    });

    testWidgets(
        'Given when user enter wrong phone format'
        'When user enter less than 10 digit'
        'Then display error message', (widgetTester) async {
      when(addInspectionBookingCubit.stream)
          .thenAnswer((_) => Stream.value(ShowUpdateProfileModal()));
      when(addInspectionBookingCubit.state)
          .thenAnswer((_) => ShowUpdateProfileModal());
      when(addInspectionBookingCubit.duration).thenReturn(15);
      //  when(addInspectionBookingCubit.phoneNo).thenReturn(null);
      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
          providers, const AddInspectionBookingBody(id: 'id')));
      await widgetTester.pumpAndSettle();
      Widget textForm = widgetTester.widget(find.byKey(const Key('phoneNo')));
      await widgetTester.enterText(find.byWidget(textForm), '1234567');
      await widgetTester.pumpAndSettle();
      expect(find.text('Must be 10 digits'), findsOne);
    });

    testWidgets(
        'Given when user enter wrong phone format'
        'When user enter wrong code area'
        'Then display error message', (widgetTester) async {
      when(addInspectionBookingCubit.stream)
          .thenAnswer((_) => Stream.value(ShowUpdateProfileModal()));
      when(addInspectionBookingCubit.state)
          .thenAnswer((_) => ShowUpdateProfileModal());
      when(addInspectionBookingCubit.duration).thenReturn(15);
      // when(addInspectionBookingCubit.phoneNo).thenReturn(null);
      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
          providers, const AddInspectionBookingBody(id: 'id')));
      await widgetTester.pumpAndSettle();
      Widget textForm = widgetTester.widget(find.byKey(const Key('phoneNo')));
      await widgetTester.enterText(find.byWidget(textForm),
          '1234 567 890'); // phone numer need to have format xxxx xxx xxx
      await widgetTester.pumpAndSettle();
      expect(find.text('Area code: 02, 03, 04, 05, 07, 08'), findsOne);
    });
    testWidgets(
        'Given user at UpdateProfileModal'
        'When user enter valid phone number'
        'When user hit save button and UpdatePhoneNumberSuccessState appear'
        'Expect Dismiss UpdatePhoneNoBottomSheetView', (widgetTester) async {
      when(addInspectionBookingCubit.stream)
          .thenAnswer((_) => Stream.value(UpdatePhoneNumberSuccessState()));
      when(addInspectionBookingCubit.state)
          .thenAnswer((_) => UpdatePhoneNumberSuccessState());
      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
          providers, const AddInspectionBookingScreen(id: 'id')));
      await widgetTester.pumpAndSettle();
      expect(
          find.byWidget(const AddInspectionBookingScreen(
            id: 'id',
          )),
          findsNothing);
    });
  });
}
