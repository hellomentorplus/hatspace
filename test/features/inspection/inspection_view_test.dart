import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/inspection/inspection_view.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:hatspace/features/inspection/viewmodel/display_item.dart';
import 'package:hatspace/features/inspection/viewmodel/inspection_cubit.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../widget_tester_extension.dart';
import 'inspection_view_test.mocks.dart';

@GenerateMocks([
  InspectCubit,
  AuthenticationService,
  StorageService,
  MemberService,
])
void main() {
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockStorageService storageService = MockStorageService();
  final MockInspectCubit inspectCubit = MockInspectCubit();
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
    when(inspectCubit.state).thenReturn(InspectionInitial());
    when(inspectCubit.stream).thenAnswer(
      (realInvocation) => const Stream.empty(),
    );

    when(authenticationService.getCurrentUser())
        .thenAnswer((realInvocation) => Future.value(UserDetail(uid: 'uid')));
  });

  testWidgets('given items is TenantItem, when launching, then show TenantView',
      (widgetTester) async {
    List<DisplayItem> items = [Header()];
    items.add(NumberOfInspectionItem(1));
    items.add(TenantBookingItem(
      'https://img.staticmb.com/mbcontent/images/uploads/2022/12/Most-Beautiful-House-in-the-World.jpg',
      'Green living space in Melbourne',
      PropertyTypes.apartment,
      4800,
      Currency.aud,
      'pw',
      'Victoria',
      '09:00 AM - 10:00 AM - 15 Sep, 2023',
      'Yolo Tim',
      null,
    ));
    when(inspectCubit.state).thenReturn(InspectionLoaded(items));
    when(memberService.getUserRoles('uid'))
        .thenAnswer((_) => Future.value([Roles.tenant]));

    await mockNetworkImagesFor(() => widgetTester.blocWrapAndPump<InspectCubit>(
        inspectCubit, const InspectionView()));

    expect(find.text('Inspection Booking'), findsOneWidget);
    expect(find.byType(TenantBookItemView), findsOneWidget);
    expect(find.byType(HomeOwnerBookItemView), findsNothing);

    // skip check dummy data, will update when getting real data
  });

  testWidgets(
      'given items is HomeOwner, when launching, then show HomeOwnerView',
      (widgetTester) async {
    List<DisplayItem> items = [Header()];
    items.add(HomeOwnerBookingItem(
      'https://img.staticmb.com/mbcontent/images/uploads/2022/12/Most-Beautiful-House-in-the-World.jpg',
      'Green living space in Melbourne',
      PropertyTypes.apartment,
      4800,
      Currency.aud,
      'pw',
      'Victoria',
      2,
    ));
    when(inspectCubit.state).thenReturn(InspectionLoaded(items));
    when(memberService.getUserRoles('uid'))
        .thenAnswer((_) => Future.value([Roles.homeowner]));

    await mockNetworkImagesFor(() => widgetTester.blocWrapAndPump<InspectCubit>(
        inspectCubit, const InspectionView()));

    expect(find.text('Inspection Booking'), findsOneWidget);
    expect(find.byType(TenantBookItemView), findsNothing);
    expect(find.byType(HomeOwnerBookItemView), findsOneWidget);
    // skip check dummy data, will update when getting real data
  });

  testWidgets('verify interaction', (widgetTester) async {
    await mockNetworkImagesFor(
        () => widgetTester.wrapAndPump(const InspectionView()));

    expect(find.byType(InspectionView), findsOneWidget);
    final Finder bookItemsFinder = find.byType(TenantBookItemView);
    expect(bookItemsFinder, findsWidgets);

    await widgetTester.ensureVisible(bookItemsFinder.first);
    await widgetTester.tap(bookItemsFinder.first);
    await widgetTester.pumpAndSettle();

    expect(find.byType(InspectionView), findsNothing);
  });
}
