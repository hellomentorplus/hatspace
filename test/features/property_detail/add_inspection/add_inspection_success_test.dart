import 'package:clock/clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/inspection.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/booking/add_inspection_success_booking_screen.dart';
import 'package:hatspace/features/inspection/viewmodel/inspection_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/inspection_storage_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/member_service/property_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/view_models/authentication/authentication_bloc.dart';
import 'package:hatspace/view_models/property/property_detail_cubit.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../find_extension.dart';
import '../../../widget_tester_extension.dart';
import './add_inspection_success_test.mocks.dart';

@GenerateMocks([
  StorageService,
  AuthenticationBloc,
  AuthenticationService,
  UserDetail,
  PropertyService,
  MemberService,
  InspectionCubit,
  InpsectionService,
  PropertyDetailCubit,
])
void main() async {
  HatSpaceStrings.load(const Locale('en'));
  initializeDateFormatting();
  final MockStorageService storageService = MockStorageService();
  final MockPropertyService propertyService = MockPropertyService();
  final MockMemberService memberService = MockMemberService();
  final MockInspectionCubit inspectionCubit = MockInspectionCubit();
  final MockInpsectionService inpsectionService = MockInpsectionService();
  final MockAuthenticationBloc authenticationBloc = MockAuthenticationBloc();
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockPropertyDetailCubit propertyDetailCubit = MockPropertyDetailCubit();
  Property property = Property(
      id: 'pId',
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
  Inspection inspection = Inspection(

      inspectionId: 'iId',

      propertyId: 'pId',
      message: '',
      startTime: DateTime(2011, 1, 1, 1, 1),
      endTime: DateTime(2011, 1, 2, 3, 4),
      createdBy: 'uid');
  inspection.inspectionId = 'iId';

  final UserDetail userDetail =
      UserDetail(uid: 'uId', avatar: '', displayName: '');
  setUpAll(() async {
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
    withClock(Clock.fixed(DateTime(2022, 10, 15)), () async {
      HsSingleton.singleton.registerSingleton<Clock>(clock);
    });
    when(inspectionCubit.state)
        .thenReturn(InspectionItem(inspection, property, userDetail));
    when(inspectionCubit.stream).thenAnswer((realInvocation) =>
        Stream.value(InspectionItem(inspection, property, userDetail)));
    when(inpsectionService.getInspectionById('iId'))
        .thenAnswer((realInvocation) => Future.value(inspection));
    when(propertyService.getProperty('pid'))
        .thenAnswer((realInvocation) => Future.value(property));
    when(memberService.getUserDetail('oid'))
        .thenAnswer((realInvocation) => Future.value(userDetail));
  });

  group('Booking inspection success test cases', () {
    testWidgets('Verify booking inspection success UI ', (widgetTester) async {
      Widget addInspectionSuccessScreen =

          const AddInspectionSuccessBody(inspectionId: 'iId');
      await mockNetworkImagesFor(() =>
          widgetTester.blocWrapAndPump<InspectionCubit>(
              inspectionCubit, addInspectionSuccessScreen));
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
      Widget addInspectionSuccessScreen = const AddInspectionSuccessBody(
        inspectionId: 'iId',
      );
      final List<BlocProvider> providers = [
        BlocProvider<PropertyDetailCubit>(
            create: (context) => propertyDetailCubit),
        BlocProvider<InspectionCubit>(
          create: (context) => inspectionCubit,
        ),
        BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc)
      ];
      when(authenticationService.getCurrentUser())
          .thenAnswer((realInvocation) => Future.value(UserDetail(uid: 'uid')));
      when(authenticationBloc.state).thenReturn(AuthenticationInitial());
      when(authenticationBloc.stream)
          .thenAnswer((realInvocation) => const Stream.empty());
      when(storageService.property).thenReturn(propertyService);
      when(storageService.member).thenReturn(memberService);
      when(storageService.property).thenReturn(propertyService);
      when(propertyService.getProperty(any))
          .thenAnswer((realInvocation) => Future.value(property));
      when(memberService.getMemberDisplayName(any))
          .thenAnswer((realInvocation) => Future.value('Owner displayName'));
      when(memberService.getMemberAvatar(any))
          .thenAnswer((realInvocation) => Future.value('photo'));
      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump(
          providers, addInspectionSuccessScreen));
      IconButton iconBtn = widgetTester.widget(find.byType(IconButton));
      expect(find.byWidget(iconBtn), findsOneWidget);
      await widgetTester.ensureVisible(find.byWidget(iconBtn));
      await widgetTester.tap(find.byType(IconButton), warnIfMissed: true);
      await widgetTester.pumpAndSettle();
      // Navigate to other screen
      expect(find.byType(AddInspectionSuccessBody), findsNothing);
    });
  });
}
