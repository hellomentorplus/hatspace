import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/inspection.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/inspection/viewmodel/inspection_cubit.dart';
import 'package:hatspace/features/inspection_detail/inspection_detail_screen.dart';
import 'package:hatspace/features/inspection_detail/widgets/inspection_information_view.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/inspection_storage_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/member_service/property_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../widget_tester_extension.dart';
import '../add_property/view/widgets/add_rooms_view_test.dart';
import './inspection_detail_screen_test.mocks.dart';

@GenerateMocks([
  InspectionCubit,
  StorageService,
  MemberService,
  PropertyService,
  AuthenticationService,
  InpsectionService
])
void main() {
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockStorageService storageService = MockStorageService();
  final MockInspectionCubit inspectionCubit = MockInspectionCubit();
  final MockMemberService memberService = MockMemberService();
  final MockPropertyService propertyService = MockPropertyService();
  final MockInpsectionService inpsectionService = MockInpsectionService();

  setUpAll(() {
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
    HsSingleton.singleton
        .registerSingleton<InpsectionService>(inpsectionService);
    HatSpaceStrings.load(const Locale('en'));
    initializeDateFormatting();
  });
  setUp(() {
    when(storageService.member).thenReturn(memberService);
    when(storageService.property).thenReturn(propertyService);
    when(storageService.inspection).thenReturn(inpsectionService);
    when(inspectionCubit.state).thenReturn(InspectionInitial());
    when(inspectionCubit.stream).thenAnswer(
      (realInvocation) => const Stream.empty(),
    );
  });
  testWidgets('test ui for widget', (widgetTester) async {
    Inspection mockInspection = Inspection(
        propertyId: 'pId',
        startTime: DateTime(2023, 9, 15, 9, 0, 0),
        endTime: DateTime(2023, 9, 15, 10, 0, 0),
        message: 'My number is 0438825121',
        createdBy: 'uId');
    Property mockProperty = Property(
        type: PropertyTypes.apartment,
        name: 'Green living space in Melbourne',
        price: Price(rentPrice: 4800),
        description: 'note',
        address: const AddressDetail(
            streetName: 'mockStreetName',
            streetNo: 'mock street no',
            postcode: 'mockPostcode',
            suburb: 'mockSuburb',
            state: AustraliaStates.vic),
        additionalDetail: const AdditionalDetail(),
        photos: ['photo1'],
        minimumRentPeriod: MinimumRentPeriod.eighteenMonths,
        location: const GeoPoint(1.0, 1.0),
        availableDate: Timestamp.fromDate(DateTime(2023, 10, 22)),
        ownerUid: 'uid');
    UserDetail mocUserDetail = UserDetail(uid: 'uId', displayName: 'Yolo Tim');

    when(inpsectionService.getInspectionById(any))
        .thenAnswer((realInvocation) => Future.value(mockInspection));
    when(propertyService.getProperty(any))
        .thenAnswer((_) => Future.value(mockProperty));
    when(memberService.getUserDetail(any))
        .thenAnswer((_) => Future.value(mocUserDetail));
    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<InspectionCubit>(
            inspectionCubit, const InspectionDetailScreen(id: '123')));

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
    await mockNetworkImagesFor(() => widgetTester.blocWrapAndPump(
        InspectionCubit(),
        const InspectionDetailScreen(
          id: '123',
        )));

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
