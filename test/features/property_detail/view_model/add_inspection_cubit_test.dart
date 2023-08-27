import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/booking/view_model/cubit/add_inspection_booking_cubit.dart';
import 'package:hatspace/features/property_detail/view_model/property_detail_cubit.dart';
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
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticatioServiceMock);
    HsSingleton.singleton.registerSingleton<StorageService>(storageServiceMock);
  });

  tearDown(() {
    reset(authenticatioServiceMock);
    reset(storageServiceMock);
    reset(mockMemberService);
  });

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

  blocTest<PropertyDetailCubit, PropertyDetailState>(
    'when trigger navigate to booking inspection'
    'then return NavigateToBookingInspectionScreen state',
    build: () => PropertyDetailCubit(),
    setUp: () {
      when(authenticatioServiceMock.isUserLoggedIn).thenReturn(true);
    },
    act: (bloc) => bloc.navigateToBooingInspectionScreen(),
    expect: () => [NavigateToBooingInspectionScreen()],
  );

  blocTest<PropertyDetailCubit, PropertyDetailState>(
    'Given when user has not logged in'
    'when user trigger navigate to booking screen'
    'then return nothing',
    build: () => PropertyDetailCubit(),
    setUp: () {
      when(authenticatioServiceMock.isUserLoggedIn).thenReturn(false);
    },
    act: (bloc) => bloc.navigateToBooingInspectionScreen(),
    expect: () => [],
  );
}
