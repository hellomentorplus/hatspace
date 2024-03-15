import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/booking/view_model/cubit/add_inspection_booking_cubit.dart';
import 'package:hatspace/features/property_detail/view_model/property_detail_interaction_cubit.dart';
import 'package:hatspace/features/property_detail/view_model/property_detail_interaction_state.dart';
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
      'When user already had phone number'
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
        when(mockMemberService.getMemberPhoneNumber('uid')).thenAnswer(
            (realInvocation) => Future.value(PhoneNumber(
                countryCode: PhoneCode.au,
                phoneNumber: '0123456789')));
      },
      act: (bloc) => bloc.onBookInspection(),
      expect: () => [BookingInspectionSuccess()]);

  blocTest<PropertyDetailInteractionCubit, PropertyDetailInteractionState>(
    'when trigger navigate to booking inspection'
    'then return NavigateToBookingInspectionScreen state',
    build: () => PropertyDetailInteractionCubit(),
    setUp: () {
      when(authenticationServiceMock.isUserLoggedIn).thenReturn(true);
      when(authenticationServiceMock.getCurrentUser())
          .thenAnswer((realInvocation) {
        return Future.value(UserDetail(uid: 'uid'));
      });
      when(mockMemberService.getUserRoles('uid')).thenAnswer((realInvocation) {
        return Future.value([Roles.tenant]);
      });
    },
    act: (bloc) => bloc.navigateToBooingInspectionScreen(),
    expect: () => [NavigateToBooingInspectionScreen()],
  );

  blocTest<PropertyDetailInteractionCubit, PropertyDetailInteractionState>(
    'Given when user has not logged in'
    'when user trigger navigate to booking screen'
    'then return nothing',
    build: () => PropertyDetailInteractionCubit(),
    setUp: () {
      when(authenticationServiceMock.isUserLoggedIn).thenReturn(false);
    },
    act: (bloc) => bloc.navigateToBooingInspectionScreen(),
    expect: () => [ShowLoginBottomModal()],
  );
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
        when(mockMemberService.getMemberPhoneNumber('uid')).thenAnswer(
            (realInvocation) => Future.value(PhoneNumber(
                countryCode: PhoneCode.au,
                phoneNumber: '0123456789')));
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
      verify: (bloc) {
        expect(bloc.state is AddInspectionBookingInitial, true);
        expect((bloc.state as AddInspectionBookingInitial).props, []);
      });
  blocTest<PropertyDetailInteractionCubit, PropertyDetailInteractionState>(
      'Given when LoginModal is displayed'
      'When user close it'
      'Then return CloseModal state',
      build: () => PropertyDetailInteractionCubit(),
      setUp: () {
        when(authenticationServiceMock.getCurrentUser())
            .thenAnswer((realInvocation) {
          return Future.value(UserDetail(uid: 'uid'));
        });
        when(authenticationServiceMock.isUserLoggedIn).thenReturn(false);
      },
      act: (bloc) => bloc.closeBottomModal(),
      expect: () => [isA<CloseBottomModal>()]);
  blocTest<PropertyDetailInteractionCubit, PropertyDetailInteractionState>(
      'Given user is in PropertyDetailScreen'
      'When user already logged in'
      'When user DO NOT HAVE Tenant role'
      'Then return RequestTenantRole state',
      build: () => PropertyDetailInteractionCubit(),
      setUp: () {
        when(authenticationServiceMock.getCurrentUser())
            .thenAnswer((realInvocation) {
          return Future.value(UserDetail(uid: 'uid'));
        });
        when(authenticationServiceMock.isUserLoggedIn).thenReturn(true);
        when(mockMemberService.getUserRoles('uid'))
            .thenAnswer((realInvocation) => Future.value([]));
      },
      act: (bloc) => bloc.navigateToBooingInspectionScreen(),
      expect: () => [isA<RequestTenantRoles>()]);

  blocTest<PropertyDetailInteractionCubit, PropertyDetailInteractionState>(
    'Given is in PropertyDetailScreen'
    'When user already logged in'
    'When user add tenant role from AddTenantRole bottom modal',
    build: () => PropertyDetailInteractionCubit(),
    setUp: () {
      when(authenticationServiceMock.getCurrentUser())
          .thenAnswer((realInvocation) {
        return Future.value(UserDetail(uid: 'uid'));
      });
      when(mockMemberService.getUserRoles('uid'))
          .thenAnswer((realInvocation) => Future.value([]));
      // when(mockMemberService.saveUserRoles('uid', {Roles.tenant})).thenAnswer((realInvocation) => Future.value(true));
    },
    act: (bloc) => bloc.addTenantRole(),
    expect: () => [isA<AddTenantRolesSuccess>()],
  );

  blocTest<PropertyDetailInteractionCubit, PropertyDetailInteractionState>(
      'Given user add tenant role fail'
      'Then return AddTenantRoleFail',
      build: () => PropertyDetailInteractionCubit(),
      setUp: () {
        when(authenticationServiceMock.getCurrentUser())
            .thenThrow(UserNotFoundException());
      },
      act: (bloc) => bloc.addTenantRole(),
      expect: () => [isA<AddTenantRoleFail>()]);

  // START TIME AND DUATION SELECTIONS
  blocTest<AddInspectionBookingCubit, AddInspectionBookingState>(
    'Given start time has not been entered'
    'When run validate startTimeSelection'
    'emit RequestStartTimeSelection',
    build: () => AddInspectionBookingCubit(),
    setUp: () {
      when(authenticationServiceMock.getCurrentUser())
          .thenAnswer((realInvocation) {
        return Future.value(UserDetail(uid: 'uid'));
      });
      when(mockMemberService.getUserRoles('uid')).thenAnswer((realInvocation) {
        return Future.value([Roles.tenant, Roles.homeowner]);
      });
    },
    act: (bloc) {
      bloc.isStartTimeSelected = false;
      bloc.selectDuration();
    },
    expect: () => [isA<RequestStartTimeSelection>()],
  );
  blocTest<AddInspectionBookingCubit, AddInspectionBookingState>(
    'Given start time has not been entered'
    'When user tap to open bottom modal'
    'Then emit ShowStartTimeSelection',
    build: () => AddInspectionBookingCubit(),
    setUp: () {
      when(authenticationServiceMock.getCurrentUser())
          .thenAnswer((realInvocation) {
        return Future.value(UserDetail(uid: 'uid'));
      });
      when(mockMemberService.getUserRoles('uid')).thenAnswer((realInvocation) {
        return Future.value([Roles.tenant, Roles.homeowner]);
      });
    },
    act: (bloc) {
      bloc.selectStartTime();
    },
    expect: () => [isA<ShowStartTimeSelection>()],
  );

  blocTest<AddInspectionBookingCubit, AddInspectionBookingState>(
    'Given start time has not been entered'
    'When run validate startTimeSelection'
    'emit RequestStartTimeSelection',
    build: () => AddInspectionBookingCubit(),
    setUp: () {
      when(authenticationServiceMock.getCurrentUser())
          .thenAnswer((realInvocation) {
        return Future.value(UserDetail(uid: 'uid'));
      });
      when(mockMemberService.getUserRoles('uid')).thenAnswer((realInvocation) {
        return Future.value([Roles.tenant, Roles.homeowner]);
      });
    },
    act: (bloc) {
      bloc.isStartTimeSelected = false;
      bloc.updateInspectionStartTime(DateTime(2020, 9, 9, 9, 9));
    },
    expect: () => [CloseStartTimeRequestMessage()],
  );

  blocTest<AddInspectionBookingCubit, AddInspectionBookingState>(
    'Given user start time AND duration already selected '
    'When validate booking button'
    'Then emit BookInspectionEnable',
    build: () => AddInspectionBookingCubit(),
    setUp: () {
      when(authenticationServiceMock.getCurrentUser())
          .thenAnswer((realInvocation) {
        return Future.value(UserDetail(uid: 'uid'));
      });
      when(mockMemberService.getUserRoles('uid')).thenAnswer((realInvocation) {
        return Future.value([Roles.tenant, Roles.homeowner]);
      });
    },
    act: (bloc) {
      bloc.inspectionStartTime;
      bloc.isStartTimeSelected = true;
      bloc.duration = 15;
      bloc.validateBookingInspectionButton();
    },
    expect: () => [isA<BookInspectionButtonEnable>()],
  );

  blocTest<AddInspectionBookingCubit, AddInspectionBookingState>(
    'Given start time has not been selected and duration already selected'
    'When validate booking button'
    'Then emit RequestStartTimeSelection',
    build: () => AddInspectionBookingCubit(),
    setUp: () {
      when(authenticationServiceMock.getCurrentUser())
          .thenAnswer((realInvocation) {
        return Future.value(UserDetail(uid: 'uid'));
      });
      when(mockMemberService.getUserRoles('uid')).thenAnswer((realInvocation) {
        return Future.value([Roles.tenant, Roles.homeowner]);
      });
    },
    act: (bloc) {
      bloc.selectDuration();
    },
    expect: () => [isA<RequestStartTimeSelection>()],
  );
  group('Show Update Profile Modal', () {
    blocTest(
        'Given user has no phone number'
        'expect emit ShowUpdateProfileModal state',
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
          when(mockMemberService.getMemberPhoneNumber('uid'))
              .thenAnswer((realInvocation) => Future.value(null));
        },
        act: (bloc) {
          bloc.onBookInspection();
        },
        expect: () => [isA<ShowUpdateProfileModal>()]);

    blocTest(
        'Given user is in ShowUpdateProfileModal'
        'When user enter and update phone number successfull'
        'expect emit UpdatePhoneNumberSuccessState',
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
          when(mockMemberService.getMemberPhoneNumber('uid'))
              .thenAnswer((realInvocation) => Future.value(null));
        },
        act: (bloc) {
          bloc.updateProfilePhoneNumber('234567890');
        },
        expect: () => [isA<UpdatePhoneNumberSuccessState>()]);
  });
  blocTest<AddInspectionBookingCubit, AddInspectionBookingState>(
    'Given duration has not been  selected'
    'When user tap on duration selection'
    'Then emit ShowDurationSelection',
    build: () => AddInspectionBookingCubit(),
    setUp: () {
      when(authenticationServiceMock.getCurrentUser())
          .thenAnswer((realInvocation) {
        return Future.value(UserDetail(uid: 'uid'));
      });
      when(mockMemberService.getUserRoles('uid')).thenAnswer((realInvocation) {
        return Future.value([Roles.tenant, Roles.homeowner]);
      });
    },
    act: (bloc) {
      bloc.isStartTimeSelected = true;
      bloc.selectDuration();
    },
    expect: () => [isA<ShowDurationSelection>()],
  );

  blocTest<AddInspectionBookingCubit, AddInspectionBookingState>(
    'Given user close modal'
    'When user tap out'
    'Then emit CloseBottomSheet',
    build: () => AddInspectionBookingCubit(),
    setUp: () {
      when(authenticationServiceMock.getCurrentUser())
          .thenAnswer((realInvocation) {
        return Future.value(UserDetail(uid: 'uid'));
      });
      when(mockMemberService.getUserRoles('uid')).thenAnswer((realInvocation) {
        return Future.value([Roles.tenant, Roles.homeowner]);
      });
    },
    act: (bloc) {
      bloc.closeBottomModal();
    },
    expect: () => [isA<CloseBottomSheet>()],
  );

  blocTest<AddInspectionBookingCubit, AddInspectionBookingState>(
    'Given user select date'
    'When user on save'
    'Then expect change start time and update date time only',
    build: () => AddInspectionBookingCubit(),
    setUp: () {
      when(authenticationServiceMock.getCurrentUser())
          .thenAnswer((realInvocation) {
        return Future.value(UserDetail(uid: 'uid'));
      });
      when(mockMemberService.getUserRoles('uid')).thenAnswer((realInvocation) {
        return Future.value([Roles.tenant, Roles.homeowner]);
      });
    },
    act: (bloc) {
      bloc.updateInspectionDateOnly(day: 9, month: 9, year: 2020);
    },
    expect: () => [],
  );
}
