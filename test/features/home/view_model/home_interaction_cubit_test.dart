import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/home/view_model/home_interaction_cubit.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_interaction_cubit_test.mocks.dart';

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
      build: () => HomeInteractionCubit(),
      setUp: () {
        when(authenticationService.getCurrentUser())
            .thenThrow(UserNotFoundException());
      },
      act: (bloc) => bloc.onAddPropertyPressed(),
      expect: () => [isA<StartValidateRole>(), isA<ShowModalLogin>()]);

  blocTest(
    'Given user has role tenant only, when handle Add Property, then return nothing',
    build: () => HomeInteractionCubit(),
    setUp: () {
      when(memberService.getUserRoles(any))
          .thenAnswer((_) => Future.value([Roles.tenant]));
    },
    act: (bloc) => bloc.onAddPropertyPressed(),
    expect: () => [isA<StartValidateRole>()],
  );

  blocTest(
    'Given user has role homeowner only, when handle Add Property, then return StartAddPropertyFlow',
    build: () => HomeInteractionCubit(),
    setUp: () {
      when(memberService.getUserRoles(any))
          .thenAnswer((_) => Future.value([Roles.homeowner]));
    },
    act: (bloc) => bloc.onAddPropertyPressed(),
    expect: () => [isA<StartValidateRole>(), isA<StartAddPropertyFlow>()],
  );

  blocTest(
    'Given user has role homeowner and tenant, when handle Add Property, then return StartAddPropertyFlow',
    build: () => HomeInteractionCubit(),
    setUp: () {
      when(memberService.getUserRoles(any))
          .thenAnswer((_) => Future.value([Roles.homeowner, Roles.tenant]));
    },
    act: (bloc) => bloc.onAddPropertyPressed(),
    expect: () => [isA<StartValidateRole>(), isA<StartAddPropertyFlow>()],
  );

  blocTest(
      'Given user has not sign in, when handle BottomAppBar time, then return ShowModalLogin',
      build: () => HomeInteractionCubit(),
      setUp: () {
        when(authenticationService.getCurrentUser())
            .thenThrow(UserNotFoundException());
      },
      act: (bloc) => bloc.onValidateLogin(BottomBarItems.booking),
      expect: () => [isA<StartValidateLogin>(), isA<ShowModalLogin>()]);
}
