import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/booking/view_model/cubit/add_inspection_booking_cubit.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../property_detail_screen_test.mocks.dart';

@GenerateMocks([MemberService])
void main() async {
  HatSpaceStrings.load(const Locale('en'));
  initializeDateFormatting();
  final MockAuthenticationService authenticatioServiceMock =
      MockAuthenticationService();
  final MockStorageService storageServiceMock = MockStorageService();
  final MockMemberService mockMemberService = MockMemberService();
  setUpAll(() async {
    when(storageServiceMock.member).thenReturn(mockMemberService);
  });

  setUp(() {
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticatioServiceMock);
    HsSingleton.singleton.registerSingleton<StorageService>(storageServiceMock);
  });

  tearDown(() {});

  // blocTest<AppleSignInCubit, AppleSignInState>(
  //     'given AppleSignIn is Available and platform is iOS, '
  //     'when checkAppleSignInAvailable, '
  //     'then return AppleSignInAvailable',
  //     build: () => AppleSignInCubit(),
  //     setUp: () {
  //       debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  //       when(authenticationService.isAppleSignInAvailable).thenReturn(true);
  //     },
  //     act: (cubit) => cubit.checkAppleSignInAvailable(),
  //     expect: () => [AppleSignInAvailable()],
  //     tearDown: () => debugDefaultTargetPlatformOverride = null);
  blocTest<AddInspectionBookingCubit, AddInspectionBookingState>(
      'Given user is booking an inspection'
      'When user already had tenant role'
      'Then return SuccessBookInspection',
      build: () => AddInspectionBookingCubit(),
      setUp: () {
        when(authenticatioServiceMock.getCurrentUser())
            .thenAnswer((realInvocation) {
          return Future.value(UserDetail(uid: 'uid'));
        });
        when(mockMemberService.getUserRoles('uid'))
            .thenAnswer((realInvocation) {
          return Future.value([Roles.tenant]);
        });
      },
      act: (bloc) => bloc.onBookInspection(),
      expect: () => [BookingInspectionSuccess()]);
}
