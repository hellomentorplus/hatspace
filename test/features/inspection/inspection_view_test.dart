import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/inspection/inspection_view.dart';
import 'package:hatspace/features/inspection/viewmodel/display_item.dart';
import 'package:hatspace/features/inspection/viewmodel/inspection_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../find_extension.dart';
import '../../widget_tester_extension.dart';
import 'inspection_view_test.mocks.dart';

@GenerateMocks([
  InspectionCubit,
  AuthenticationService,
  StorageService,
  MemberService,
])
void main() {
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockStorageService storageService = MockStorageService();
  final MockInspectionCubit inspectionCubit = MockInspectionCubit();
  final MockMemberService memberService = MockMemberService();

  setUpAll(() {
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
    HatSpaceStrings.load(const Locale('en'));
    initializeDateFormatting();
  });

  setUp(() {
    when(storageService.member).thenReturn(memberService);
    when(inspectionCubit.state).thenReturn(InspectionInitial());
    when(inspectionCubit.stream).thenAnswer(
      (realInvocation) => const Stream.empty(),
    );

    when(authenticationService.getCurrentUser())
        .thenAnswer((realInvocation) => Future.value(UserDetail(uid: 'uid')));
  });

  // TODO: Remove comment when implement business logic of getting propertyList
  // testWidgets('given items is TenantItem, when launching, then show TenantView',
  //     (widgetTester) async {
  //   List<DisplayItem> items = [Header()];
  //   items.add(NumberOfInspectionItem(1));
  //   items.add(TenantBookingItem(
  //     '1',
  //     'https://img.staticmb.com/mbcontent/images/uploads/2022/12/Most-Beautiful-House-in-the-World.jpg',
  //     'Green living space in Melbourne',
  //     PropertyTypes.apartment,
  //     4800,
  //     Currency.aud,
  //     'pw',
  //     AustraliaStates.vic,
  //     '09:00 AM - 10:00 AM - 15 Sep, 2023',
  //     'Yolo Tim',
  //     null,
  //   ));
  //   when(inspectionCubit.state).thenReturn(InspectionLoaded(items));
  //   when(inspectionCubit.stream).thenAnswer((realInvocation) => Stream.value(InspectionLoaded(items)));
  //   when(memberService.getUserRoles('uid'))
  //       .thenAnswer((_) => Future.value([Roles.tenant]));
  //   when(inspectionCubit.getBookedPropertyList()).thenAnswer((realInvocation) {
  //     return Future.value([NumberOfInspectionItem(1),TenantBookingItem(
  //     '1',
  //     'https://img.staticmb.com/mbcontent/images/uploads/2022/12/Most-Beautiful-House-in-the-World.jpg',
  //     'Green living space in Melbourne',
  //     PropertyTypes.apartment,
  //     4800,
  //     Currency.aud,
  //     'pw',
  //     AustraliaStates.vic,
  //     '09:00 AM - 10:00 AM - 15 Sep, 2023',
  //     'Yolo Tim',
  //     null,
  //   )]);
  //   });
  //   await mockNetworkImagesFor(() =>
  //       widgetTester.blocWrapAndPump<InspectionCubit>(
  //           inspectionCubit, const InspectionView()));

  //   expect(find.text('Inspection Booking'), findsOneWidget);
  //   expect(find.byType(TenantBookItemView), findsOneWidget);
  //   expect(find.byType(HomeOwnerBookItemView), findsNothing);

  //   // skip check dummy data, will update when getting real data
  // });

  // TODO: Remove comment when implement business logic of getting propertyList
  // testWidgets(
  //     'given items is HomeOwner, when launching, then show HomeOwnerView',
  //     (widgetTester) async {
  //   List<DisplayItem> items = [Header()];
  //   items.add(HomeOwnerBookingItem(
  //     '1',
  //     'https://img.staticmb.com/mbcontent/images/uploads/2022/12/Most-Beautiful-House-in-the-World.jpg',
  //     'Green living space in Melbourne',
  //     PropertyTypes.apartment,
  //     4800,
  //     Currency.aud,
  //     'pw',
  //     AustraliaStates.vic,
  //     2,
  //   ));
  //   when(inspectionCubit.state).thenReturn(InspectionLoaded(items));
  //   when(memberService.getUserRoles('uid'))
  //       .thenAnswer((_) => Future.value([Roles.homeowner]));
  //   await mockNetworkImagesFor(() =>
  //       widgetTester.blocWrapAndPump<InspectionCubit>(
  //           inspectionCubit, const InspectionView()));

  //   expect(find.text('Inspection Booking'), findsOneWidget);
  //   expect(find.byType(TenantBookItemView), findsNothing);
  //   expect(find.byType(HomeOwnerBookItemView), findsOneWidget);
  //   // skip check dummy data, will update when getting real data
  // });

  testWidgets('verify tenant booking item tap', (widgetTester) async {
    List<DisplayItem> items = [Header()];
    items.add(NumberOfInspectionItem(1));
    items.add(TenantBookingItem(
      '1',
      'https://img.staticmb.com/mbcontent/images/uploads/2022/12/Most-Beautiful-House-in-the-World.jpg',
      'Green living space in Melbourne',
      PropertyTypes.apartment,
      4800,
      Currency.aud,
      'pw',
      AustraliaStates.vic,
      '09:00 AM - 10:00 AM - 15 Sep, 2023',
      'Yolo Tim',
      null,
    ));
    when(inspectionCubit.state).thenReturn(InspectionLoaded(items));
    when(memberService.getUserRoles('uid'))
        .thenAnswer((_) => Future.value([Roles.tenant]));

    mockNetworkImagesFor(() async {
      await widgetTester.blocWrapAndPump<InspectionCubit>(
          inspectionCubit, const InspectionBody());

      expect(find.byType(InspectionBody), findsOneWidget);
      expect(find.byType(TenantBookItemView), findsOneWidget);
      expect(find.byType(HomeOwnerBookItemView), findsNothing);
      final Finder bookItemsFinder = find.byType(TenantBookItemView);
      expect(bookItemsFinder, findsOneWidget);

      await widgetTester.ensureVisible(bookItemsFinder);
      await widgetTester.pump(const Duration(seconds: 1));
      await widgetTester.tap(bookItemsFinder);
      await widgetTester.pumpAndSettle();

      expect(find.byType(InspectionBody), findsNothing);
    });
  });

  // TODO: Remove comment when implement business logic of getting propertyList
  // testWidgets('verify homeowner booking item tap', (widgetTester) async {
  //   List<DisplayItem> items = [Header()];
  //   items.add(HomeOwnerBookingItem(
  //     '1',
  //     'https://img.staticmb.com/mbcontent/images/uploads/2022/12/Most-Beautiful-House-in-the-World.jpg',
  //     'Green living space in Melbourne',
  //     PropertyTypes.apartment,
  //     4800,
  //     Currency.aud,
  //     'pw',
  //     AustraliaStates.vic,
  //     1,
  //   ));
  //   when(inspectionCubit.state).thenReturn(InspectionLoaded(items));
  //   when(inspectionCubit.stream).thenAnswer((_) => Stream.value(InspectionLoaded(items)));
  //   when(memberService.getUserRoles('uid'))
  //       .thenAnswer((_) => Future.value([Roles.homeowner]));

  //   await mockNetworkImagesFor(() =>
  //       widgetTester.blocWrapAndPump<InspectionCubit>(
  //           inspectionCubit, const InspectionView()));
  //   final Finder homeOwnerInspectionFinder = find.byType(HomeOwnerBookItemView);
  //   expect(homeOwnerInspectionFinder, findsOneWidget);

  //   await widgetTester.tap(homeOwnerInspectionFinder);
  //   await widgetTester.pumpAndSettle();

  //   expect(find.byType(InspectionView), findsNothing);
  //   expect(find.byType(InspectionConfirmationListScreen), findsOneWidget);
  // });

  testWidgets(
      'verify UI when user either homeowner or tenant roles'
      'when user does not have any property'
      'Then expect no booking widget display', (widgetTester) async {
    when(inspectionCubit.state).thenReturn(NoBookedInspection());
    when(inspectionCubit.stream)
        .thenAnswer((_) => Stream.value(NoBookedInspection()));

    when(memberService.getUserRoles('uid'))
        .thenAnswer((_) => Future.value([Roles.homeowner, Roles.tenant]));

    await mockNetworkImagesFor(() =>
        widgetTester.blocWrapAndPump<InspectionCubit>(
            inspectionCubit, const InspectionView()));
    final Finder homeOwnerInspectionFinder = find.byType(HomeOwnerBookItemView);
    // HomeOwnerBookItemView should not be displayed
    expect(homeOwnerInspectionFinder, findsNothing);
    final Finder tenantBookItemView = find.byType(TenantBookItemView);
    // TenantBookItemView should not be displayed;
    expect(tenantBookItemView, findsNothing);
    final Finder noBookingIcon =
        find.svgPictureWithAssets(Assets.icons.noBookingLarge);
    expect(noBookingIcon, findsOneWidget);
    expect(find.text('No booking'), findsOneWidget);
  });
}
