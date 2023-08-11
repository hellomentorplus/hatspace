import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/profile/view_model/profile_cubit.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_cubit_test.mocks.dart';

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

  blocTest<ProfileCubit, ProfileState>(
      'Given authentication service can not get user detail. '
      'When get user detail from Authentication service. '
      'Then emit state with orders : GettingUserDetailState -> GetUserDetailFailedState.',
      build: () => ProfileCubit(),
      setUp: () {
        when(authenticationService.getCurrentUser())
            .thenThrow(Exception('Failed to fetch user'));
      },
      act: (bloc) => bloc.getUserInformation(),
      expect: () =>
          [isA<GettingUserDetailState>(), isA<GetUserDetailFailedState>()]);

  blocTest<ProfileCubit, ProfileState>(
      'Given get user detail successfully. '
      'When get user role from Storage service. '
      'Then emit state with orders : GettingUserDetailState -> GetUserDetailSucceedState.',
      build: () => ProfileCubit(),
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

  blocTest<ProfileCubit, ProfileState>(
      'Given MyProfileCubit was just created. '
      'When user do nothing. '
      'Then state will be GetUserDetailInitialState.',
      build: () => ProfileCubit(),
      verify: (bloc) {
        expect(bloc.state is ProfileInitialState, true);
      });

  blocTest<ProfileCubit, ProfileState>(
      'when logOut, '
      'then return LogOutAccountSucceedState and signOut is called',
      build: () => ProfileCubit(),
      setUp: () {
        when(authenticationService.signOut())
            .thenAnswer((_) => Future.value(null));
      },
      act: (bloc) => bloc.logOut(),
      verify: (_) {
        verify(authenticationService.signOut()).called(1);
      },
      expect: () => [
            isA<LogOutAccountSucceedState>(),
          ]);
}
