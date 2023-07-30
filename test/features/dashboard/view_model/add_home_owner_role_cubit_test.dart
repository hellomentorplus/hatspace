import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/dashboard/view_model/add_home_owner_role_cubit.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_home_owner_role_cubit_test.mocks.dart';

@GenerateMocks([AuthenticationService, StorageService, MemberService])
void main() {
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockStorageService storageService = MockStorageService();
  final MockMemberService memberService = MockMemberService();

  setUpAll(() {
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);

    when(storageService.member).thenReturn(memberService);
  });

  blocTest(
    'given user detail not found,'
    'when addHomeOwnerRole,'
    'then return AddHomeOwnerRoleError',
    build: () => AddHomeOwnerRoleCubit(),
    setUp: () {
      when(authenticationService.getCurrentUser())
          .thenThrow(UserNotFoundException());
    },
    act: (bloc) => bloc.addHomeOwnerRole(),
    expect: () => [isA<AddHomeOwnerRoleError>()],
  );

  blocTest(
    'given user detail available,'
    'when addHomeOwnerRole,'
    'then return AddHomeOwnerRoleSucceeded,'
    'and save homeowner role to user',
    build: () => AddHomeOwnerRoleCubit(),
    setUp: () {
      when(authenticationService.getCurrentUser())
          .thenAnswer((realInvocation) => Future.value(UserDetail(uid: 'uid')));
      when(memberService.getUserRoles(any))
          .thenAnswer((realInvocation) => Future.value([Roles.tenant]));
    },
    act: (bloc) => bloc.addHomeOwnerRole(),
    expect: () => [isA<AddHomeOwnerRoleSucceeded>()],
    verify: (bloc) {
      verify(memberService
          .saveUserRoles('uid', {Roles.tenant, Roles.homeowner})).called(1);
    },
  );
}
