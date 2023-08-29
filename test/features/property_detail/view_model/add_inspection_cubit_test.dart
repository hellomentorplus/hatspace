import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/booking/view_model/cubit/add_inspection_booking_cubit.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_inspection_cubit_test.mocks.dart';

@GenerateMocks([MemberService, AuthenticationService, StorageService])
void main() async {
  HatSpaceStrings.load(const Locale('en'));
  initializeDateFormatting();
  final MockAuthenticationService authenticationServiceMock =
      MockAuthenticationService();
  final MockStorageService storageServiceMock = MockStorageService();
  final MockMemberService mockMemberService = MockMemberService();
  setUpAll(() async {
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationServiceMock);
    HsSingleton.singleton.registerSingleton<StorageService>(storageServiceMock);
    when(storageServiceMock.member).thenReturn(mockMemberService);
  });

  blocTest<AddInspectionBookingCubit, AddInspectionBookingState>(
      'Given user is booking an inspection'
      'When user already had tenant role'
      'Then return SuccessBookInspection',
      build: () => AddInspectionBookingCubit(),
      setUp: () {
        when(authenticationServiceMock.getCurrentUser())
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

  blocTest<AddInspectionBookingCubit, AddInspectionBookingState>(
      'Given user is booking an inspection'
      'When user already had tenant and homeowner role'
      'Then return SuccessBookInspection',
      build: () => AddInspectionBookingCubit(),
      setUp: () {
        when(authenticationServiceMock.getCurrentUser())
            .thenAnswer((realInvocation) {
          return Future.value(UserDetail(uid: 'uid'));
        });
        when(mockMemberService.getUserRoles('uid'))
            .thenAnswer((realInvocation) {
          return Future.value([Roles.tenant, Roles.homeowner]);
        });
      },
      act: (bloc) => bloc.onBookInspection(),
      expect: () => [BookingInspectionSuccess()]);

  blocTest<AddInspectionBookingCubit, AddInspectionBookingState>(
      'Given user is booking an inspection'
      'When user only had homeowner role'
      'Then do not emit success state',
      build: () => AddInspectionBookingCubit(),
      setUp: () {
        when(authenticationServiceMock.getCurrentUser())
            .thenAnswer((realInvocation) {
          return Future.value(UserDetail(uid: 'uid'));
        });
        when(mockMemberService.getUserRoles('uid'))
            .thenAnswer((realInvocation) {
          return Future.value([Roles.homeowner]);
        });
      },
      act: (bloc) => bloc.onBookInspection(),
      expect: () => []);

  blocTest<AddInspectionBookingCubit, AddInspectionBookingState>(
      'Given authentication service failed to get current user. '
      'When user is booking an inspection. '
      'Then UserNotFoundException will be thrown.',
      build: () => AddInspectionBookingCubit(),
      setUp: () {
        when(authenticationServiceMock.getCurrentUser())
            .thenThrow(UserNotFoundException());
      },
      act: (bloc) => bloc.onBookInspection(),
      verify: (_) => [isA<UserNotFoundException>()]);

  blocTest<AddInspectionBookingCubit, AddInspectionBookingState>(
      'Given AddInspectionBookingCubit was just created. '
      'Then state will be AddInspectionBookingInitial.',
      build: () => AddInspectionBookingCubit(),
      act: (bloc) => bloc.onBookInspection(),
      verify: (bloc) {
        expect(bloc.state is AddInspectionBookingInitial, true);
        expect((bloc.state as AddInspectionBookingInitial).props, []);
      });
}
