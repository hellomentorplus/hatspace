import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/sign_up/view_model/choose_role_cubit.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'choose_role_bloc_test.mocks.dart';

@GenerateMocks([
  AuthenticationService,
  StorageService,
  MemberService,
  UserDetail
])
void main() {
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockStorageService storageServiceMock = MockStorageService();
  final MockMemberService memberService = MockMemberService();
  final MockUserDetail mockUserDetail = MockUserDetail();
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
    HsSingleton.singleton.registerSingleton<StorageService>(storageServiceMock);
    when(storageServiceMock.member).thenAnswer((realInvocation) {
      return memberService;
    });
  });

  test(
      'Given ChooseRoleBloc just has been created.'
      'Then the initial state must be ChoosingRoleState with no roles.', () {
    expect(
        ChooseRoleCubit().state,
        isA<ChoosingRoleState>()
            .having((p0) => p0.roles.length, 'Roles is empty', 0));
  });

  blocTest<ChooseRoleCubit, ChooseRoleState>(
      'Given bloc was just created and no events have been fired.'
      'When ChooseRoleEvent with param Roles.tenant.'
      'Then new state will be ChoosingRoleState with Roles.tenant.',
      build: () => ChooseRoleCubit(),
      act: (bloc) => bloc.changeRole(Roles.tenant),
      expect: () => [
            isA<ChoosingRoleState>()
                .having((p0) => p0.roles, 'Matched roles', {Roles.tenant})
          ]);

  blocTest<ChooseRoleCubit, ChooseRoleState>(
      'Given current state is ChoosingRoleState with the Roles.tenant as data '
      'and authenticationService get current user successfully.'
      'and storageService save user roles successfully.'
      'When fire SubmitRoleEvent.'
      'Then new state will be ChoosingRoleState with Roles.tenant.',
      build: () => ChooseRoleCubit(),
      setUp: () {
        when(authenticationService.getCurrentUser())
            .thenAnswer((realInvocation) {
          return Future<UserDetail>.value(mockUserDetail);
        });
        when(mockUserDetail.uid).thenReturn('uid');
        when(memberService.saveUserRoles(mockUserDetail.uid, any))
            .thenAnswer((realInvocation) => Future<void>.value());
      },
      act: (bloc) => bloc.submitUserRoles(),
      expect: () => [
            const SubmittingRoleState(),
            const SubmitRoleSucceedState(),
            // isA<SubmitRoleSucceedState>(),
          ]);

  blocTest<ChooseRoleCubit, ChooseRoleState>(
    'Given current state is ChoosingRoleState with the Roles.tenant as data '
    'and authenticationService get current user function throws an Exception.'
    'and storageService save user roles successfully.'
    'When fire SubmitRoleEvent.'
    'Then new state must be SubmitRoleFailedState.',
    build: () => ChooseRoleCubit(),
    setUp: () {
      when(authenticationService.getCurrentUser()).thenThrow(Exception());
      when(memberService.saveUserRoles(mockUserDetail.uid, any))
          .thenAnswer((realInvocation) => Future<void>.value());
    },
    act: (bloc) => bloc.submitUserRoles(),
    expect: () => [const SubmittingRoleState(), const SubmitRoleFailedState()],
  );

  blocTest<ChooseRoleCubit, ChooseRoleState>(
    'Given current state is ChoosingRoleState with the Roles.tenant as data '
    'and authenticationService get current user successfully.'
    'and storageService save user roles function throws an Exception.'
    'When fire SubmitRoleEvent.'
    'Then new state must be SubmitRoleFailedState.',
    build: () => ChooseRoleCubit(),
    setUp: () {
      when(authenticationService.getCurrentUser()).thenThrow(Exception());
      when(memberService.saveUserRoles(mockUserDetail.uid, any))
          .thenAnswer((realInvocation) => Future<void>.value());
    },
    act: (bloc) => bloc.submitUserRoles(),
    expect: () => [
      const SubmittingRoleState(),
      const SubmitRoleFailedState(),
      // isA<SubmitRoleFailedState>(),
    ],
  );
}
