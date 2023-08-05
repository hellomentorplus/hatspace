import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/dashboard/view_model/dashboard_interaction_cubit.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/permission/permission_service.dart';
import 'package:hatspace/models/permission/permission_status.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dashboard_interaction_cubit_test.mocks.dart';

@GenerateMocks([
  StorageService,
  AuthenticationService,
  MemberService,
  HsPermissionService,
  DashboardInteractionCubit
])
void main() {
  final MockStorageService storageService = MockStorageService();
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockMemberService memberService = MockMemberService();
  final MockHsPermissionService hsPermissionService = MockHsPermissionService();
  setUpAll(() {
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
    HsSingleton.singleton
        .registerSingleton<HsPermissionService>(hsPermissionService);
  });

  setUp(() {
    when(storageService.member).thenReturn(memberService);
    when(authenticationService.getCurrentUser())
        .thenAnswer((realInvocation) => Future.value(UserDetail(uid: 'uid')));
    when(memberService.getUserRoles(any)).thenAnswer((_) => Future.value([]));
  });

  tearDown(() {
    reset(storageService);
    reset(authenticationService);
    reset(memberService);
    reset(hsPermissionService);
  });

  blocTest(
      'given user is not logged in, when handle Add Property, then return nothing',
      build: () => DashboardInteractionCubit(),
      setUp: () {
        when(authenticationService.getCurrentUser())
            .thenThrow(UserNotFoundException());
      },
      act: (bloc) => bloc.onAddPropertyPressed(),
      expect: () => [isA<StartValidateRole>()]);

  blocTest(
    'Given user has role tenant only, when handle Add Property, then return RequestHomeOwnerRole ',
    build: () => DashboardInteractionCubit(),
    setUp: () {
      when(memberService.getUserRoles(any))
          .thenAnswer((_) => Future.value([Roles.tenant]));
    },
    act: (bloc) => bloc.onAddPropertyPressed(),
    expect: () => [isA<StartValidateRole>(), isA<RequestHomeOwnerRole>()],
  );

  blocTest(
    'given user has role homeowner only and photo permission status is granted, '
    'when handle Add Property, '
    'then return PhotoPermissionGranted',
    build: () => DashboardInteractionCubit(),
    setUp: () {
      when(memberService.getUserRoles(any))
          .thenAnswer((_) => Future.value([Roles.homeowner]));
      when(hsPermissionService.checkPhotoPermission()).thenAnswer(
          (realInvocation) => Future.value(HsPermissionStatus.granted));
    },
    act: (bloc) => bloc.onAddPropertyPressed(),
    expect: () => [isA<StartValidateRole>(), isA<PhotoPermissionGranted>()],
  );

  blocTest(
    'given user has role homeowner only and photo permission status is limited, '
    'when handle Add Property, '
    'then return PhotoPermissionGranted',
    build: () => DashboardInteractionCubit(),
    setUp: () {
      when(memberService.getUserRoles(any))
          .thenAnswer((_) => Future.value([Roles.homeowner]));
      when(hsPermissionService.checkPhotoPermission()).thenAnswer(
          (realInvocation) => Future.value(HsPermissionStatus.limited));
    },
    act: (bloc) => bloc.onAddPropertyPressed(),
    expect: () => [isA<StartValidateRole>(), isA<PhotoPermissionGranted>()],
  );

  blocTest(
    'given user has role homeowner only and photo permission status is denied, '
    'when handle Add Property, '
    'then return PhotoPermissionDenied',
    build: () => DashboardInteractionCubit(),
    setUp: () {
      when(memberService.getUserRoles(any))
          .thenAnswer((_) => Future.value([Roles.homeowner]));
      when(hsPermissionService.checkPhotoPermission()).thenAnswer(
          (realInvocation) => Future.value(HsPermissionStatus.denied));
    },
    act: (bloc) => bloc.onAddPropertyPressed(),
    expect: () => [isA<StartValidateRole>(), isA<PhotoPermissionDenied>()],
  );

  blocTest(
    'given user has role homeowner only and photo permission status is deniedForever, '
    'when handle Add Property, '
    'then return PhotoPermissionDeniedForever',
    build: () => DashboardInteractionCubit(),
    setUp: () {
      when(memberService.getUserRoles(any))
          .thenAnswer((_) => Future.value([Roles.homeowner]));
      when(hsPermissionService.checkPhotoPermission()).thenAnswer(
          (realInvocation) => Future.value(HsPermissionStatus.deniedForever));
    },
    act: (bloc) => bloc.onAddPropertyPressed(),
    expect: () =>
        [isA<StartValidateRole>(), isA<PhotoPermissionDeniedForever>()],
  );

  blocTest(
    'given user has role homeowner and tenant  and photo permission status is granted, '
    'when handle Add Property, '
    'then return PhotoPermissionGranted',
    build: () => DashboardInteractionCubit(),
    setUp: () {
      when(memberService.getUserRoles(any))
          .thenAnswer((_) => Future.value([Roles.homeowner, Roles.tenant]));
      when(hsPermissionService.checkPhotoPermission()).thenAnswer(
          (realInvocation) => Future.value(HsPermissionStatus.granted));
    },
    act: (bloc) => bloc.onAddPropertyPressed(),
    expect: () => [isA<StartValidateRole>(), isA<PhotoPermissionGranted>()],
  );

  blocTest(
    'given user has role homeowner and tenant  and photo permission status is limited, '
    'when handle Add Property, '
    'then return PhotoPermissionGranted',
    build: () => DashboardInteractionCubit(),
    setUp: () {
      when(memberService.getUserRoles(any))
          .thenAnswer((_) => Future.value([Roles.homeowner, Roles.tenant]));
      when(hsPermissionService.checkPhotoPermission()).thenAnswer(
          (realInvocation) => Future.value(HsPermissionStatus.limited));
    },
    act: (bloc) => bloc.onAddPropertyPressed(),
    expect: () => [isA<StartValidateRole>(), isA<PhotoPermissionGranted>()],
  );

  blocTest(
    'given user has role homeowner and tenant  and photo permission status is denied, '
    'when handle Add Property, '
    'then return PhotoPermissionDenied',
    build: () => DashboardInteractionCubit(),
    setUp: () {
      when(memberService.getUserRoles(any))
          .thenAnswer((_) => Future.value([Roles.homeowner, Roles.tenant]));
      when(hsPermissionService.checkPhotoPermission()).thenAnswer(
          (realInvocation) => Future.value(HsPermissionStatus.denied));
    },
    act: (bloc) => bloc.onAddPropertyPressed(),
    expect: () => [isA<StartValidateRole>(), isA<PhotoPermissionDenied>()],
  );

  blocTest(
    'given user has role homeowner and tenant  and photo permission status is deniedForever, '
    'when handle Add Property, '
    'then return PhotoPermissionDeniedForever',
    build: () => DashboardInteractionCubit(),
    setUp: () {
      when(memberService.getUserRoles(any))
          .thenAnswer((_) => Future.value([Roles.homeowner, Roles.tenant]));
      when(hsPermissionService.checkPhotoPermission()).thenAnswer(
          (realInvocation) => Future.value(HsPermissionStatus.deniedForever));
    },
    act: (bloc) => bloc.onAddPropertyPressed(),
    expect: () =>
        [isA<StartValidateRole>(), isA<PhotoPermissionDeniedForever>()],
  );

  blocTest(
      'Given user has not logged in, when user taps on Explore, then return OpenLoginBottomSheetModal',
      build: () => DashboardInteractionCubit(),
      setUp: () {
        when(authenticationService.isUserLoggedIn).thenReturn(false);
      },
      act: (bloc) => bloc.onBottomItemTapped(BottomBarItems.explore),
      expect: () => [isA<OpenLoginBottomSheetModal>()]);

  blocTest(
      'Given user has not logged in, when user taps on Booking, then return OpenLoginBottomSheetModal',
      build: () => DashboardInteractionCubit(),
      setUp: () {
        when(authenticationService.isUserLoggedIn).thenReturn(false);
      },
      act: (bloc) => bloc.onBottomItemTapped(BottomBarItems.booking),
      expect: () => [isA<OpenLoginBottomSheetModal>()]);

  blocTest(
      'Given user has not logged in, when user taps on Message, then return OpenLoginBottomSheetModal',
      build: () => DashboardInteractionCubit(),
      setUp: () {
        when(authenticationService.isUserLoggedIn).thenReturn(false);
      },
      act: (bloc) => bloc.onBottomItemTapped(BottomBarItems.message),
      expect: () => [isA<OpenLoginBottomSheetModal>()]);

  blocTest(
      'Given user has not logged in, when user taps on Profile, then return OpenLoginBottomSheetModal',
      build: () => DashboardInteractionCubit(),
      setUp: () {
        when(authenticationService.isUserLoggedIn).thenReturn(false);
      },
      act: (bloc) => bloc.onBottomItemTapped(BottomBarItems.profile),
      expect: () => [isA<OpenLoginBottomSheetModal>()]);

  blocTest(
      'Given user has not logged in, when user taps on Adding property, then return OpenLoginBottomSheetModal',
      build: () => DashboardInteractionCubit(),
      setUp: () {
        when(authenticationService.isUserLoggedIn).thenReturn(false);
      },
      act: (bloc) => bloc.onBottomItemTapped(BottomBarItems.addingProperty),
      expect: () => [isA<OpenLoginBottomSheetModal>()]);

  blocTest(
      'Given user has not logged in, when user taps out, then return CloseHsModal',
      build: () => DashboardInteractionCubit(),
      setUp: () {
        when(authenticationService.isUserLoggedIn).thenReturn(false);
      },
      act: (bloc) => bloc.onCloseModal(),
      expect: () => [isA<CloseHsModal>()]);

  blocTest(
    'when cancelPhotoAccess,'
    'then return CancelPhotoAccess',
    build: () => DashboardInteractionCubit(),
    act: (bloc) => bloc.cancelPhotoAccess(),
    expect: () => [isA<CancelPhotoAccess>()],
  );

  blocTest(
    'when gotoSetting,'
    'then return OpenSettingScreen',
    build: () => DashboardInteractionCubit(),
    setUp: () => TestWidgetsFlutterBinding.ensureInitialized(),
    act: (bloc) => bloc.gotoSetting(),
    expect: () => [isA<OpenSettingScreen>()],
  );

  blocTest<DashboardInteractionCubit, DashboardInteractionState>(
    'given state is OpenSettingScreen,'
    'when onDismissModal,'
    'then do nothing',
    build: () => DashboardInteractionCubit(),
    seed: () => OpenSettingScreen(),
    act: (bloc) => bloc.onDismissModal(),
    expect: () => [],
  );

  blocTest<DashboardInteractionCubit, DashboardInteractionState>(
    'given state is CancelPhotoAccess,'
    'when onDismissModal,'
    'then return nothing',
    build: () => DashboardInteractionCubit(),
    seed: () => CancelPhotoAccess(),
    act: (bloc) => bloc.onDismissModal(),
    expect: () => [],
  );

  blocTest<DashboardInteractionCubit, DashboardInteractionState>(
    'given state is PhotoPermissionGranted,'
    'when onDismissModal,'
    'then return DismissPhotoPermissionBottomSheet',
    build: () => DashboardInteractionCubit(),
    seed: () => PhotoPermissionGranted(),
    act: (bloc) => bloc.onDismissModal(),
    expect: () => [isA<DismissPhotoPermissionBottomSheet>()],
  );

  blocTest<DashboardInteractionCubit, DashboardInteractionState>(
    'given state is CancelPhotoAccess,'
    'when onDismissModal,'
    'then return nothing',
    build: () => DashboardInteractionCubit(),
    seed: () => CancelPhotoAccess(),
    act: (bloc) => bloc.onDismissModal(),
    expect: () => [],
  );

  blocTest<DashboardInteractionCubit, DashboardInteractionState>(
    'given last state is OpenSettingScreen and photo permission returns PhotoPermissionGranted,'
    'when onScreenResumed,'
    'then return PhotoPermissionGranted',
    build: () => DashboardInteractionCubit(),
    setUp: () {
      when(hsPermissionService.checkPhotoPermission()).thenAnswer(
          (realInvocation) => Future.value(HsPermissionStatus.granted));
    },
    seed: () => OpenSettingScreen(),
    act: (bloc) => bloc.onScreenResumed(),
    verify: (_) {
      verify(hsPermissionService.checkPhotoPermission()).called(1);
    },
    expect: () => [isA<PhotoPermissionGranted>()],
  );

  blocTest<DashboardInteractionCubit, DashboardInteractionState>(
    'given last state is OpenSettingScreen and photo permission returns PhotoPermissionDenied,'
    'when onScreenResumed,'
    'then return PhotoPermissionDenied',
    build: () => DashboardInteractionCubit(),
    setUp: () {
      when(hsPermissionService.checkPhotoPermission()).thenAnswer(
          (realInvocation) => Future.value(HsPermissionStatus.denied));
    },
    seed: () => OpenSettingScreen(),
    act: (bloc) => bloc.onScreenResumed(),
    verify: (_) {
      verify(hsPermissionService.checkPhotoPermission()).called(1);
    },
    expect: () => [isA<PhotoPermissionDenied>()],
  );

  blocTest<DashboardInteractionCubit, DashboardInteractionState>(
    'given last state is OpenSettingScreen and photo permission returns PhotoPermissionDeniedForever,'
    'when onScreenResumed,'
    'then return PhotoPermissionDeniedForever',
    build: () => DashboardInteractionCubit(),
    setUp: () {
      when(hsPermissionService.checkPhotoPermission()).thenAnswer(
          (realInvocation) => Future.value(HsPermissionStatus.deniedForever));
    },
    seed: () => OpenSettingScreen(),
    act: (bloc) => bloc.onScreenResumed(),
    verify: (_) {
      verify(hsPermissionService.checkPhotoPermission()).called(1);
    },
    expect: () => [isA<PhotoPermissionDeniedForever>()],
  );

  blocTest<DashboardInteractionCubit, DashboardInteractionState>(
    'given last state is DismissPhotoPermissionBottomSheet,'
    'when onScreenResumed,'
    'then return nothing',
    build: () => DashboardInteractionCubit(),
    seed: () => DismissPhotoPermissionBottomSheet(),
    act: (bloc) => bloc.onScreenResumed(),
    verify: (_) {
      verifyNever(hsPermissionService.checkPhotoPermission());
    },
    expect: () => [],
  );

  blocTest(
    'when onNavigateToAddPropertyFlow,'
    'then return NavigateToAddPropertyFlow',
    build: () => DashboardInteractionCubit(),
    act: (bloc) => bloc.onNavigateToAddPropertyFlow(),
    expect: () => [isA<NavigateToAddPropertyFlow>()],
  );

  group('On Tap Bottom items interaction flow', () {
    // Navigate expected screen after login success from login modal
    blocTest<DashboardInteractionCubit, DashboardInteractionState>(
      'when user login success after being navigated by tapping Booking'
      'then navigate to Booking screen',
      setUp: () {
        when(authenticationService.isUserLoggedIn).thenReturn(true);
      },
      seed: () => CloseLoginModal(),
      build: () => DashboardInteractionCubit(),
      act: (bloc) {
        bloc.pressedBottomBarItem = BottomBarItems.booking;
        return bloc.navigateToExpectedScreen();
      },
      expect: () => [const OpenPage(BottomBarItems.booking)],
    );

    blocTest<DashboardInteractionCubit, DashboardInteractionState>(
      'when user login success after being navigated by tapping Message'
      'then navigate to Message screen',
      setUp: () {
        when(authenticationService.isUserLoggedIn).thenReturn(true);
      },
      seed: () => CloseLoginModal(),
      build: () => DashboardInteractionCubit(),
      act: (bloc) {
        bloc.pressedBottomBarItem = BottomBarItems.message;
        return bloc.navigateToExpectedScreen();
      },
      expect: () => [const OpenPage(BottomBarItems.message)],
    );

    blocTest<DashboardInteractionCubit, DashboardInteractionState>(
      'when user login success after being navigated by tapping Profile'
      'then navigate to Profile screen',
      setUp: () {
        when(authenticationService.isUserLoggedIn).thenReturn(true);
      },
      seed: () => CloseLoginModal(),
      build: () => DashboardInteractionCubit(),
      act: (bloc) {
        bloc.pressedBottomBarItem = BottomBarItems.profile;
        return bloc.navigateToExpectedScreen();
      },
      expect: () => [const OpenPage(BottomBarItems.profile)],
    );

    blocTest<DashboardInteractionCubit, DashboardInteractionState>(
      'when user login success after being navigated by tapping Explore'
      'then navigate to Explore screen',
      setUp: () {
        when(authenticationService.isUserLoggedIn).thenReturn(true);
      },
      seed: () => CloseLoginModal(),
      build: () => DashboardInteractionCubit(),
      act: (bloc) {
        bloc.pressedBottomBarItem = BottomBarItems.explore;
        return bloc.navigateToExpectedScreen();
      },
      expect: () => [const OpenPage(BottomBarItems.explore)],
    );
  });
}
