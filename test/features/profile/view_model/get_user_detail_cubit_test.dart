import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/profile/view_model/get_user_detail_cubit.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_user_detail_cubit_test.mocks.dart';

@GenerateMocks([StorageService, AuthenticationService, MemberService])
@GenerateNiceMocks([MockSpec<UserDetail>()])
void main() {
  final MockStorageService storageService = MockStorageService();
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockMemberService memberService = MockMemberService();

  setUpAll(() async {
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
    when(storageService.member).thenReturn(memberService);
  });

  blocTest(
      'Given authentication service can not get user detail. '
      'When get user detail from Authentication service. '
      'Then emit state with orders : GettingUserDetailState -> GetUserDetailFailedState.',
      build: () => GetUserDetailCubit(),
      setUp: () {
        when(authenticationService.getCurrentUser())
            .thenThrow(Exception('Failed to fetch user'));
      },
      act: (bloc) => bloc.getUserInformation(),
      expect: () =>
          [isA<GettingUserDetailState>(), isA<GetUserDetailFailedState>()]);

  blocTest(
      'Given authentication service returns user detail successfully and member service failed to return user roles. '
      'When get user information. '
      'Then emit state with orders : GettingUserDetailState -> GetUserDetailFailedState.',
      build: () => GetUserDetailCubit(),
      setUp: () {
        when(authenticationService.getCurrentUser())
            .thenAnswer((_) => Future.value(MockUserDetail()));
        when(memberService.getUserRoles('uid'))
            .thenThrow(Exception('Failed to get roles'));
      },
      act: (bloc) => bloc.getUserInformation(),
      expect: () => [
            isA<GettingUserDetailState>(),
            isA<GetUserDetailFailedState>(),
          ]);

  blocTest(
      'Given get user detail successfully and get user roles successfully. '
      'When get user role from Storage service. '
      'Then emit state with orders : GettingUserDetailState -> GetUserDetailSucceedState.',
      build: () => GetUserDetailCubit(),
      setUp: () {
        final MockUserDetail mockUser = MockUserDetail();
        when(authenticationService.getCurrentUser())
            .thenAnswer((_) => Future.value(mockUser));
        when(memberService.getUserRoles(mockUser.uid))
            .thenAnswer((_) => Future.value(Roles.values));
      },
      act: (bloc) => bloc.getUserInformation(),
      expect: () => [
            isA<GettingUserDetailState>(),
            isA<GetUserDetailSucceedState>(),
          ]);
}
