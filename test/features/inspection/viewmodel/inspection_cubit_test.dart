import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/inspection/viewmodel/inspection_cubit.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'inspection_cubit_test.mocks.dart';

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

  blocTest<InspectCubit, InspectionState>(
      'given authentication service can not get user detail. '
      'when get user role from Authentication service. '
      'then return GetUserRolesFailed.',
      build: () => InspectCubit(),
      setUp: () {
        when(authenticationService.getCurrentUser())
            .thenThrow(Exception('Failed to fetch user'));
      },
      act: (bloc) => bloc.getUserRole(),
      expect: () => [isA<GetUserRolesFailed>()]);

  blocTest<InspectCubit, InspectionState>(
      'given authentication service can get user detail. '
      'when get user role from Authentication service. '
      'then return InspectionLoaded.',
      build: () => InspectCubit(),
      setUp: () {
        final MockUserDetail mockUser = MockUserDetail();
        when(authenticationService.getCurrentUser())
            .thenAnswer((_) => Future.value(mockUser));
        when(memberService.getUserRoles(mockUser.uid))
            .thenAnswer((_) => Future.value(Roles.values));
      },
      act: (bloc) => bloc.getUserRole(),
      expect: () => [isA<InspectionLoaded>()]);
}
