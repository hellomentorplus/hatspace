import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/profile/my_profile/view_model/my_profile_cubit.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'my_profile_cubit_test.mocks.dart';

@GenerateMocks([AuthenticationService, StorageService])
@GenerateNiceMocks([MockSpec<UserDetail>()])
void main() {
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockStorageService storageService = MockStorageService();

  setUpAll(() async {
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
  });

  blocTest<MyProfileCubit, MyProfileState>(
      'Given authentication service can not get user detail. '
      'When get user detail from Authentication service. '
      'Then emit state with orders : GettingUserInformationState -> GetUserInformationFailedState.',
      build: () => MyProfileCubit(),
      setUp: () {
        when(authenticationService.getCurrentUser())
            .thenThrow(Exception('Failed to fetch user'));
      },
      act: (bloc) => bloc.getUserInformation(),
      expect: () => [
            isA<GettingUserInformationState>(),
            isA<GetUserInformationFailedState>()
          ]);

  blocTest<MyProfileCubit, MyProfileState>(
      'Given authentication service returns user detail successfully. '
      'When get user detail from Authentication service. '
      'Then emit state with orders : GettingUserInformationState -> GetUserInformationSucceedState.',
      build: () => MyProfileCubit(),
      setUp: () {
        when(authenticationService.getCurrentUser())
            .thenAnswer((_) => Future.value(MockUserDetail()));
      },
      act: (bloc) => bloc.getUserInformation(),
      expect: () => [
            isA<GettingUserInformationState>(),
            isA<GetUserInformationSucceedState>()
          ]);

  blocTest<MyProfileCubit, MyProfileState>(
      'Given MyProfileCubit was just created. '
      'When user do nothing. '
      'Then state will be GetUserDetailInitialState.',
      build: () => MyProfileCubit(),
      verify: (bloc) {
        expect(bloc.state is MyProfileInitialState, true);
      });
}
