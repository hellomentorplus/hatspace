import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/dashboard/view_model/dashboard_interaction_cubit.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dashboard_interaction_cubit_test.mocks.dart';

@GenerateMocks([StorageService, AuthenticationService, MemberService])
void main() {
  final MockStorageService storageService = MockStorageService();
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockMemberService memberService = MockMemberService();

  setUpAll(() {
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
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
    'Given user has role homeowner only, when handle Add Property, then return StartAddPropertyFlow',
    build: () => DashboardInteractionCubit(),
    setUp: () {
      when(memberService.getUserRoles(any))
          .thenAnswer((_) => Future.value([Roles.homeowner]));
    },
    act: (bloc) => bloc.onAddPropertyPressed(),
    expect: () => [isA<StartValidateRole>(), isA<StartAddPropertyFlow>()],
  );

  blocTest(
    'Given user has role homeowner and tenant, when handle Add Property, then return StartAddPropertyFlow',
    build: () => DashboardInteractionCubit(),
    setUp: () {
      when(memberService.getUserRoles(any))
          .thenAnswer((_) => Future.value([Roles.homeowner, Roles.tenant]));
    },
    act: (bloc) => bloc.onAddPropertyPressed(),
    expect: () => [isA<StartValidateRole>(), isA<StartAddPropertyFlow>()],
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