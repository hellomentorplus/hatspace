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

@GenerateMocks(
    [StorageService, AuthenticationService, MemberService, HsPermissionService])
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
}
