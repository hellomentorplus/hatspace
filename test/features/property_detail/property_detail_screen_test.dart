import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/property_detail/property_detail_screen.dart';
import 'package:hatspace/features/property_detail/view_model/property_detail_cubit.dart';
import 'package:hatspace/features/property_detail/view_model/property_detail_interaction_cubit.dart';
import 'package:hatspace/features/property_detail/view_model/property_detail_interaction_state.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/member_service/property_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_warning_bottom_sheet.dart';
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
  AuthenticationService,
  PropertyDetailInteractionCubit
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
  final MockPropertyDetailInteractionCubit mockPropertyDetailInteractionCubit =
      MockPropertyDetailInteractionCubit();

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

    when(mockPropertyDetailInteractionCubit.state)
        .thenAnswer((realInvocation) => PropertyDetailInteractionInitial());
    when(mockPropertyDetailInteractionCubit.stream).thenAnswer(
        (realInvocation) => Stream.value(PropertyDetailInteractionInitial()));

    when(authenticationService.getCurrentUser())
        .thenAnswer((realInvocation) => Future.value(UserDetail(uid: 'uid')));
  });

  tearDown(() {
    reset(authenticationBloc);
    reset(storageService);
    reset(propertyService);
    reset(memberService);
    reset(propertyDetailCubit);
    reset(authenticationService);
    reset(mockPropertyDetailInteractionCubit);
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
    const Widget widget = PropertyDetailBody(id: 'id');

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump([
          BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc,
          ),
          BlocProvider<PropertyDetailCubit>(
            create: (context) => propertyDetailCubit,
          ),
          BlocProvider<PropertyDetailInteractionCubit>(
              create: (context) => mockPropertyDetailInteractionCubit)
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
    expect(find.text('10, streetName, suburb, Victoria 1234'), findsOneWidget);
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
    expect(find.text('property description'), findsOneWidget);

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

  group('verify show more label', () {
    testWidgets(
        'given feature list is more than 4,'
        ' when load PropertyDetailScreen,'
        ' then show feature with Show More label, and counter',
        (widgetTester) async {
      const Widget widget = PropertyDetailScreen(id: 'id');

      await mockNetworkImagesFor(() => widgetTester
          .blocWrapAndPump<AuthenticationBloc>(authenticationBloc, widget));

      // on feature list
      expect(find.text('Show more (6)'), findsOneWidget);
      // on description
      expect(find.text('Show more'), findsNothing);
    });

    testWidgets(
        'given feature list is exactly 4,'
        ' when load PropertyDetailScreen,'
        ' then do not show feature with Show More label, and counter',
        (widgetTester) async {
      final Property property = Property(
          type: PropertyTypes.apartment,
          name: 'property name',
          price: Price(currency: Currency.aud, rentPrice: 100),
          description: 'property description',
          address: const AddressDetail(
            streetNo: '10',
            streetName: 'streetName',
            state: AustraliaStates.vic,
            postcode: '1234',
            suburb: 'suburb',
          ),
          additionalDetail: AdditionalDetail(
              bathrooms: 1,
              bedrooms: 1,
              parkings: 1,
              additional:
                  Feature.values.sublist(0, 4).map((e) => e.name).toList()),
          photos: ['photo1', 'photo2', 'photo3', 'photo4'],
          minimumRentPeriod: MinimumRentPeriod.sixMonths,
          location: const GeoPoint(1.0, 1.0),
          availableDate: Timestamp.fromDate(DateTime(2023, 10, 22)),
          ownerUid: 'ownerUid');
      when(propertyService.getProperty(any))
          .thenAnswer((realInvocation) => Future.value(property));

      const Widget widget = PropertyDetailScreen(id: 'id');

      await mockNetworkImagesFor(() => widgetTester
          .blocWrapAndPump<AuthenticationBloc>(authenticationBloc, widget));

      // only on description
      expect(find.byType(ShowMoreLabel), findsNothing);
    });

    testWidgets(
        'given feature list is less 4,'
        ' when load PropertyDetailScreen,'
        ' then do not show feature with Show More label, and counter',
        (widgetTester) async {
      final Property property = Property(
          type: PropertyTypes.apartment,
          name: 'property name',
          price: Price(currency: Currency.aud, rentPrice: 100),
          description: 'property description',
          address: const AddressDetail(
            streetNo: '10',
            streetName: 'streetName',
            state: AustraliaStates.vic,
            postcode: '1234',
            suburb: 'suburb',
          ),
          additionalDetail: AdditionalDetail(
              bathrooms: 1,
              bedrooms: 1,
              parkings: 1,
              additional:
                  Feature.values.sublist(0, 3).map((e) => e.name).toList()),
          photos: ['photo1', 'photo2', 'photo3', 'photo4'],
          minimumRentPeriod: MinimumRentPeriod.sixMonths,
          location: const GeoPoint(1.0, 1.0),
          availableDate: Timestamp.fromDate(DateTime(2023, 10, 22)),
          ownerUid: 'ownerUid');
      when(propertyService.getProperty(any))
          .thenAnswer((realInvocation) => Future.value(property));

      const Widget widget = PropertyDetailScreen(id: 'id');

      await mockNetworkImagesFor(() => widgetTester
          .blocWrapAndPump<AuthenticationBloc>(authenticationBloc, widget));

      expect(find.byType(ShowMoreLabel), findsNothing);
    });
  });

  testWidgets(
      'Given user is in PropertyDetail and user is ALREADY LOGGED IN'
      'When user has tenant roles'
      'When user tap on Book Inspection'
      'Then navigate to AddInspectionView', (widgetTester) async {
    const Widget widget = PropertyDetailScreen(id: 'id');
    when(memberService.getUserRoles('uid'))
        .thenAnswer((realInvocation) => Future.value([Roles.tenant]));
    when(authenticationService.isUserLoggedIn).thenReturn(true);
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
  testWidgets(
      'Given user is in PropertyDetail AND user is a ower (isOwner == true) of the property'
      'Then user is not able to see Booking Inspection button',
      (widgetTester) async {
    when(propertyDetailCubit.state).thenAnswer((realInvocation) {
      return PropertyDetailLoaded(
          photos: const [],
          name: 'name',
          state: 'state',
          bedrooms: 1,
          bathrooms: 1,
          carspaces: 1,
          description: 'description',
          fullAddress: 'address',
          features: const [],
          ownerName: 'owner name',
          ownerAvatar: 'avatar',
          availableDate: DateTime.parse('2017-09-20'),
          type: 'apartment',
          price: Price(),
          isOwned: true);
    });
    when(propertyDetailCubit.stream)
        .thenAnswer((realInvocation) => const Stream.empty());
    when(mockPropertyDetailInteractionCubit.state)
        .thenAnswer((realInvocation) => PropertyDetailInteractionInitial());
    when(mockPropertyDetailInteractionCubit.stream)
        .thenAnswer((realInvocation) => const Stream.empty());
    const Widget widget = PropertyDetailBody(id: 'uid');
    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump([
          BlocProvider<AuthenticationBloc>(
              create: (context) => authenticationBloc),
          BlocProvider<PropertyDetailCubit>(
              create: ((context) => propertyDetailCubit)),
          BlocProvider<PropertyDetailInteractionCubit>(
              create: (context) => mockPropertyDetailInteractionCubit)
        ], widget));
    expect(find.widgetWithText(PrimaryButton, 'Book Inspection'), findsNothing);
  });
  testWidgets(
      'Given when user is at Property Detail Screen'
      'AND user HAS NOT LOGGED IN'
      'when user tap on Booking inspection button'
      'then DO NOT navigate to any screens', (widgetTester) async {
    const Widget widget = PropertyDetailScreen(id: 'id');
    when(authenticationService.isUserLoggedIn).thenReturn(false);
    await mockNetworkImagesFor(() => widgetTester
        .blocWrapAndPump<AuthenticationBloc>(authenticationBloc, widget));
    expect(
        find.widgetWithText(PrimaryButton, 'Book Inspection'), findsOneWidget);
    await widgetTester
        .tap(find.widgetWithText(PrimaryButton, 'Book Inspection'));
    await mockNetworkImagesFor(() => widgetTester.pumpAndSettle());
    //     // Still in PropertyDetailScreen
    expect(find.byType(PropertyDetailScreen), findsOneWidget);
  });

  testWidgets(
      'given description is empty, when load property details, then do not show description',
      (widgetTester) async {
    when(propertyDetailCubit.state).thenReturn(PropertyDetailLoaded(
        photos: const [],
        name: 'name',
        state: 'state',
        bedrooms: 1,
        bathrooms: 1,
        carspaces: 1,
        description: '',
        fullAddress: 'address',
        features: const [],
        ownerName: 'owner name',
        ownerAvatar: 'avatar',
        availableDate: DateTime.parse('2017-09-20'),
        type: 'apartment',
        price: Price(),
        isOwned: true));
    const Widget widget = PropertyDetailBody(id: 'uid');

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump([
          BlocProvider<AuthenticationBloc>(
              create: (context) => authenticationBloc),
          BlocProvider<PropertyDetailCubit>(
              create: ((context) => propertyDetailCubit)),
          BlocProvider<PropertyDetailInteractionCubit>(
              create: (context) => mockPropertyDetailInteractionCubit)
        ], widget));

    expect(find.byType(PropertyDescriptionView), findsNothing);
  });

  testWidgets(
      'given description is not empty, when load property details, then do not show description',
      (widgetTester) async {
    when(propertyDetailCubit.state).thenReturn(PropertyDetailLoaded(
        photos: const [],
        name: 'name',
        state: 'state',
        bedrooms: 1,
        bathrooms: 1,
        carspaces: 1,
        description: 'description',
        fullAddress: 'address',
        features: const [],
        ownerName: 'owner name',
        ownerAvatar: 'avatar',
        availableDate: DateTime.parse('2017-09-20'),
        type: 'apartment',
        price: Price(),
        isOwned: true));
    const Widget widget = PropertyDetailBody(id: 'uid');

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump([
          BlocProvider<AuthenticationBloc>(
              create: (context) => authenticationBloc),
          BlocProvider<PropertyDetailCubit>(
              create: ((context) => propertyDetailCubit)),
          BlocProvider<PropertyDetailInteractionCubit>(
              create: (context) => PropertyDetailInteractionCubit())
        ], widget));

    expect(find.byType(PropertyDescriptionView), findsOneWidget);
  });

  testWidgets(
      'given description is short,'
      ' when load property details,'
      ' then do not use stack animation to display text,'
      ' and do not show Show more label', (widgetTester) async {
    when(propertyDetailCubit.state).thenReturn(PropertyDetailLoaded(
        photos: const [],
        name: 'name',
        state: 'state',
        bedrooms: 1,
        bathrooms: 1,
        carspaces: 1,
        description: 'description',
        fullAddress: 'address',
        features: const [],
        ownerName: 'owner name',
        ownerAvatar: 'avatar',
        availableDate: DateTime.parse('2017-09-20'),
        type: 'apartment',
        price: Price(),
        isOwned: true));
    const Widget widget = PropertyDetailBody(id: 'uid');

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump([
          BlocProvider<AuthenticationBloc>(
              create: (context) => authenticationBloc),
          BlocProvider<PropertyDetailCubit>(
              create: ((context) => propertyDetailCubit)),
          BlocProvider<PropertyDetailInteractionCubit>(
              create: (context) => PropertyDetailInteractionCubit())
        ], widget));

    expect(find.byType(SizeTransition), findsNothing);
    expect(find.byType(FadeTransition), findsNothing);
    expect(find.byType(ShowMoreLabel), findsNothing);
  });

  testWidgets(
      'given description is more than 3 lines,'
      ' when load property details,'
      ' then use stack animation to display text,'
      ' and show Show more label', (widgetTester) async {
    when(propertyDetailCubit.state).thenReturn(PropertyDetailLoaded(
        photos: const [],
        name: 'name',
        state: 'state',
        bedrooms: 1,
        bathrooms: 1,
        carspaces: 1,
        description: 'description\nanother line\nnew line\n4th line',
        fullAddress: 'address',
        features: const [],
        ownerName: 'owner name',
        ownerAvatar: 'avatar',
        availableDate: DateTime.parse('2017-09-20'),
        type: 'apartment',
        price: Price(),
        isOwned: true));
    const Widget widget = PropertyDetailBody(id: 'uid');

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump([
          BlocProvider<AuthenticationBloc>(
              create: (context) => authenticationBloc),
          BlocProvider<PropertyDetailCubit>(
              create: ((context) => propertyDetailCubit)),
          BlocProvider<PropertyDetailInteractionCubit>(
              create: (context) => PropertyDetailInteractionCubit())
        ], widget));

    expect(find.byType(SizeTransition), findsOneWidget);
    expect(find.byType(ShowMoreLabel), findsOneWidget);
  });
  group('Show Login Modal - Show AddTenantModal', () {
    testWidgets(
        'Given when user has not logged in'
        'Given when user is not a homeowner of the property'
        'When user tap on book inspecption button'
        'Then show login bottom sheet modal', (widgetTester) async {
      Widget widget = const PropertyDetailScreen(id: 'id');
      when(authenticationService.isUserLoggedIn).thenReturn(false);
      when(authenticationService.isAppleSignInAvailable).thenReturn(false);
      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump([
            BlocProvider<AuthenticationBloc>(
                create: (context) => authenticationBloc),
            BlocProvider<PropertyDetailCubit>(
                create: ((context) => propertyDetailCubit)),
            BlocProvider<PropertyDetailInteractionCubit>(
                create: (context) => mockPropertyDetailInteractionCubit)
          ], widget));
      await widgetTester.tap(
          find.widgetWithText(PrimaryButton, 'Book Inspection'),
          warnIfMissed: true);
      await widgetTester.pumpAndSettle();
      // display login bottom modal
      expectLater(find.byType(HsWarningBottomSheetView), findsOneWidget);

      PrimaryButton loginBtn = widgetTester
          .widget(find.widgetWithText(PrimaryButton, 'Yes, login now'));
      await widgetTester.tap(find.byWidget(loginBtn));
      await widgetTester.pumpAndSettle();
      // navigate to different screen
      expectLater(find.byType(HsWarningBottomSheetView), findsNothing);
      expectLater(find.byType(PropertyDetailScreen), findsNothing);
    });

    testWidgets(
        'Given user logged in'
        'When user DOES NOT HAVE tenant role'
        'Then show addTenantBottomModal'
        'Then tap outside of the Modal'
        'Then dismiss the modal', (widgetTester) async {
      Widget widget = const PropertyDetailScreen(id: 'id');
      when(authenticationService.isUserLoggedIn).thenReturn(true);
      when(memberService.getUserRoles('uid'))
          .thenAnswer((realInvocation) => Future.value([]));
      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump([
            BlocProvider<AuthenticationBloc>(
                create: (context) => authenticationBloc),
            BlocProvider<PropertyDetailCubit>(
                create: ((context) => propertyDetailCubit)),
            BlocProvider<PropertyDetailInteractionCubit>(
                create: (context) => mockPropertyDetailInteractionCubit)
          ], widget));
      await widgetTester.tap(
          find.widgetWithText(PrimaryButton, 'Book Inspection'),
          warnIfMissed: true);
      await widgetTester.pumpAndSettle();
      expectLater(find.byType(HsWarningBottomSheetView), findsOneWidget);
      expect(find.text('Add Tenant role'), findsOneWidget);
      expect(
          find.text(
              'Homeowner can not use this feature. Would you like to add the role Homeowner to the list of roles?'),
          findsOneWidget);
      await widgetTester.tapAt(const Offset(50, 50));
      await widgetTester.pumpAndSettle();
      expectLater(find.byType(HsWarningBottomSheetView), findsNothing);
    });

    testWidgets(
        'Given AddTenantBottomModal shows on PropertyDetailScreen'
        'When User tap at AddTenantRole button'
        'Then verify addTenantRole ', (widgetTester) async {
      Widget widget = const PropertyDetailScreen(id: 'id');
      when(authenticationService.isUserLoggedIn).thenReturn(true);
      when(memberService.getUserRoles('uid'))
          .thenAnswer((realInvocation) => Future.value([]));
      when(mockPropertyDetailInteractionCubit.addTenantRole())
          .thenAnswer((realInvocation) {});
      when(memberService.saveUserRoles('uid', {Roles.tenant}))
          .thenAnswer((realInvocation) {
        return Future.value();
      });
      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump([
            BlocProvider<AuthenticationBloc>(
                create: (context) => authenticationBloc),
            BlocProvider<PropertyDetailCubit>(
                create: ((context) => propertyDetailCubit)),
            BlocProvider<PropertyDetailInteractionCubit>(
                create: (context) => mockPropertyDetailInteractionCubit)
          ], widget));
      await widgetTester.tap(
          find.widgetWithText(PrimaryButton, 'Book Inspection'),
          warnIfMissed: true);
      await mockNetworkImagesFor(() => widgetTester.pumpAndSettle());
      expectLater(find.byType(HsWarningBottomSheetView), findsOneWidget);
      expect(find.text('Add Tenant role'), findsOneWidget);
      await widgetTester.tap(
          find.widgetWithText(PrimaryButton, 'Add Tenant Role'),
          warnIfMissed: true);
      await mockNetworkImagesFor(() => widgetTester.pumpAndSettle());
      expect(find.byType(PropertyDetailScreen), findsNothing);
    });
  });
}
