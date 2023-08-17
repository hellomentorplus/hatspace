import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/property_detail/property_detail_screen.dart';
import 'package:hatspace/features/property_detail/view_model/property_detail_cubit.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/member_service/property_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/view_models/authentication/authentication_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../find_extension.dart';
import '../../widget_tester_extension.dart';
import 'property_detail_screen_test.mocks.dart';

@GenerateMocks([
  AuthenticationBloc,
  StorageService,
  PropertyService,
  MemberService,
  PropertyDetailCubit,
  AuthenticationService
])
void main() async {
  await initializeDateFormatting();

  final MockAuthenticationBloc authenticationBloc = MockAuthenticationBloc();
  final MockStorageService storageService = MockStorageService();
  final MockPropertyService propertyService = MockPropertyService();
  final MockMemberService memberService = MockMemberService();
  final MockPropertyDetailCubit propertyDetailCubit = MockPropertyDetailCubit();
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();

  final Property property = Property(
      type: PropertyTypes.apartment,
      name: 'property name',
      price: Price(currency: Currency.aud, rentPrice: 100),
      description: 'property description',
      address: const AddressDetail(
        streetNo: '10',
        streetName: 'streetName',
        state: AustraliaStates.vic,
        postcode: 1234,
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

  setUpAll(() {
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
  });

  setUp(() {
    when(authenticationBloc.state).thenReturn(AuthenticationInitial());
    when(authenticationBloc.stream)
        .thenAnswer((realInvocation) => const Stream.empty());

    when(storageService.property).thenReturn(propertyService);
    when(storageService.member).thenReturn(memberService);

    when(propertyService.getProperty(any))
        .thenAnswer((realInvocation) => Future.value(property));
    when(memberService.getMemberDisplayName(any))
        .thenAnswer((realInvocation) => Future.value('Owner displayName'));
    when(memberService.getMemberAvatar(any))
        .thenAnswer((realInvocation) => Future.value('photo'));

    when(propertyDetailCubit.state).thenReturn(PropertyDetailInitial());
    when(propertyDetailCubit.stream).thenAnswer(
      (realInvocation) => const Stream.empty(),
    );

    when(authenticationService.getCurrentUser())
        .thenAnswer((realInvocation) => Future.value(UserDetail(uid: 'uid')));
  });

  tearDown(() {
    reset(authenticationBloc);
    reset(storageService);
    reset(propertyService);
    reset(memberService);
    reset(propertyDetailCubit);
  });

  testWidgets('verify UI component on Bloc components on PropertyDetailScreen',
      (widgetTester) async {
    const Widget widget = PropertyDetailScreen(
      id: 'id',
    );

    await mockNetworkImagesFor(() => widgetTester
        .blocWrapAndPump<AuthenticationBloc>(authenticationBloc, widget));

    expect(find.byType(BlocProvider<PropertyDetailCubit>), findsOneWidget);
  });

  testWidgets(
      'given user is not login, when load PropertyDetailBody, then do not show Location',
      (widgetTester) async {
    when(authenticationBloc.state)
        .thenAnswer((realInvocation) => AnonymousState());

    const Widget widget = PropertyDetailBody();

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump([
          BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc,
          ),
          BlocProvider<PropertyDetailCubit>(
            create: (context) => propertyDetailCubit,
          )
        ], widget));

    expect(find.text('Location'), findsNothing);
    expect(find.text('10 streetName, suburb, 1234, Victoria'), findsNothing);
  });

  testWidgets(
      'given user is login, when load PropertyDetailBody, then show Location',
      (widgetTester) async {
    when(authenticationBloc.state).thenAnswer((realInvocation) =>
        AuthenticatedState(UserDetail(uid: 'uid', displayName: 'displayName')));

    const Widget widget = PropertyDetailScreen(id: 'id');
    await mockNetworkImagesFor(() => widgetTester
        .blocWrapAndPump<AuthenticationBloc>(authenticationBloc, widget));

    expect(find.text('Location'), findsOneWidget);
    expect(find.text('10 streetName, suburb, 1234, Victoria'), findsOneWidget);
  });

  testWidgets(
      'given property is loaded, when load PropertyDetailScreen, then all info is loaded correctly',
      (widgetTester) async {
    const Widget widget = PropertyDetailScreen(id: 'id');

    await mockNetworkImagesFor(() => widgetTester
        .blocWrapAndPump<AuthenticationBloc>(authenticationBloc, widget));

    expect(find.text('Apartment'), findsOneWidget);
    expect(find.text('property name'), findsOneWidget);
    expect(find.text('Victoria'), findsOneWidget);
    // 1 short text, and 1 long text
    expect(find.text('property description'), findsNWidgets(2));

    expect(
        find.roomCount(bedrooms: 1, bathroom: 1, parkings: 1), findsOneWidget);

    expect(find.text('Owner displayName'), findsOneWidget);

    // check all features
    expect(find.text('Fridge'), findsOneWidget);
    expect(find.text('Washing machine'), findsOneWidget);
    expect(find.text('Swimming pool'), findsOneWidget);
    expect(find.text('Air conditioners'), findsOneWidget);
    expect(find.text('Electric stove'), findsOneWidget);
    expect(find.text('TV'), findsOneWidget);
    expect(find.text('Wifi'), findsOneWidget);
    expect(find.text('Security cameras'), findsOneWidget);
    expect(find.text('Kitchen'), findsOneWidget);
    expect(find.text('Portable Fans'), findsOneWidget);
  });

  testWidgets(
      'Given user is in PropertyDetail'
      'When user tap on Property'
      'Then navigate to AddInspectionView', (widgetTester) async {
    const Widget widget = PropertyDetailScreen(id: 'id');
    await mockNetworkImagesFor(() => widgetTester
        .blocWrapAndPump<AuthenticationBloc>(authenticationBloc, widget));
    expect(
        find.widgetWithText(PrimaryButton, 'Book Inspection'), findsOneWidget);
    await widgetTester
        .tap(find.widgetWithText(PrimaryButton, 'Book Inspection'));
    await mockNetworkImagesFor(() => widgetTester.pumpAndSettle());
    //     // Navigate to other screen
    expect(find.byType(PropertyDetailScreen), findsNothing);
  });
}
