import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/inspection.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/inspection/viewmodel/inspection_cubit.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/member_service/inspection_storage_service.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/member_service/property_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'inspection_cubit_test.mocks.dart';

@GenerateMocks([
  StorageService,
  AuthenticationService,
  MemberService,
  InpsectionService,
  PropertyService,
  Inspection,
  Property
])
@GenerateNiceMocks([MockSpec<UserDetail>()])
void main() {
  final MockStorageService storageService = MockStorageService();
  final MockAuthenticationService authenticationService =
      MockAuthenticationService();
  final MockMemberService memberService = MockMemberService();
  final MockInpsectionService inpsectionService = MockInpsectionService();
  final MockPropertyService propertyService = MockPropertyService();

  setUpAll(() async {
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);
    HsSingleton.singleton
        .registerSingleton<AuthenticationService>(authenticationService);
    when(storageService.member).thenReturn(memberService);
    when(storageService.inspection).thenReturn(inpsectionService);
    when(storageService.property).thenReturn(propertyService);
  });

  blocTest<InspectionCubit, InspectionState>(
      'given authentication service can not get user detail. '
      'when get user role from Authentication service. '
      'then return GetUserRolesFailed.',
      build: () => InspectionCubit(),
      setUp: () {
        when(authenticationService.getCurrentUser())
            .thenThrow(Exception('Failed to fetch user'));
      },
      act: (bloc) => bloc.getUserRole(),
      expect: () => [isA<GetUserRolesFailed>()]);

  blocTest<InspectionCubit, InspectionState>(
      'given authentication service can get user detail. '
      'when get user role from Authentication service. '
      'when user role is TENANT ONLY'
      'then return InspectionLoaded.',
      build: () => InspectionCubit(),
      setUp: () {
        final MockUserDetail mockUser = MockUserDetail();
        when(authenticationService.getCurrentUser())
            .thenAnswer((_) => Future.value(mockUser));
        when(memberService.getUserRoles(mockUser.uid))
            .thenAnswer((_) => Future.value([Roles.tenant]));
        when(memberService.getInspectionList(mockUser.uid))
            .thenAnswer((realInvocation) => Future.value(['iId1']));
        when(inpsectionService.getInspectionById('iId1')).thenAnswer((_) =>
            Future.value(Inspection(
                propertyId: 'pId',
                startTime: DateTime(2011, 1, 1, 1, 1),
                endTime: DateTime(2011, 1, 2, 3, 4),
                createdBy: 'uid')));
        when(propertyService.getProperty('pId')).thenAnswer((_) => Future.value(
            Property(
                type: PropertyTypes.house,
                name: 'mock name',
                price: Price(currency: Currency.aud, rentPrice: 1000),
                description: 'mock description',
                address: const AddressDetail(
                    streetName: 'streetName',
                    streetNo: 'streetNo',
                    postcode: '3172',
                    suburb: 'suburb',
                    state: AustraliaStates.act),
                additionalDetail: const AdditionalDetail(),
                photos: ['photo1'],
                minimumRentPeriod: MinimumRentPeriod.eighteenMonths,
                location: const GeoPoint(90.0, 90.0),
                availableDate: Timestamp.now(),
                ownerUid: 'oid')));
        when(memberService.getUserDetail('oid')).thenAnswer(
            (realInvocation) => Future.value(UserDetail(uid: 'uid')));
      },
      act: (bloc) => bloc.getUserRole(),
      expect: () => [isA<InspectionLoaded>()]);

  blocTest<InspectionCubit, InspectionState>(
      'given authentication service can get user detail. '
      'when get user role from Authentication service. '
      'when user does not have any booked inspection'
      'then return NoBookedInspection.',
      build: () => InspectionCubit(),
      setUp: () {
        final MockUserDetail mockUser = MockUserDetail();
        when(authenticationService.getCurrentUser())
            .thenAnswer((_) => Future.value(mockUser));
        when(memberService.getUserRoles(mockUser.uid))
            .thenAnswer((_) => Future.value(Roles.values));
        when(memberService.getInspectionList(mockUser.uid))
            .thenAnswer((realInvocation) => Future.value([]));
      },
      act: (bloc) => bloc.getUserRole(),
      expect: () => [isA<NoBookedInspection>()]);
  blocTest<InspectionCubit, InspectionState>(
      'given when user are booking inspection'
      'when book inspection success'
      'expect emit InspectionItem',
      build: () => InspectionCubit(),
      setUp: () {
        when(inpsectionService.getInspectionById('iId')).thenAnswer((_) =>
            Future.value(Inspection(
                propertyId: 'pId',
                startTime: DateTime(2011, 1, 1, 1, 1),
                endTime: DateTime(2011, 1, 2, 3, 4),
                createdBy: 'uid')));
        when(propertyService.getProperty('pId')).thenAnswer((_) => Future.value(
            Property(
                type: PropertyTypes.house,
                name: 'mock name',
                price: Price(currency: Currency.aud, rentPrice: 1000),
                description: 'mock description',
                address: const AddressDetail(
                    streetName: 'streetName',
                    streetNo: 'streetNo',
                    postcode: '3172',
                    suburb: 'suburb',
                    state: AustraliaStates.act),
                additionalDetail: const AdditionalDetail(),
                photos: [],
                minimumRentPeriod: MinimumRentPeriod.eighteenMonths,
                location: const GeoPoint(90.0, 90.0),
                availableDate: Timestamp.now(),
                ownerUid: 'oid')));
        when(memberService.getUserDetail('oid')).thenAnswer(
            (realInvocation) => Future.value(UserDetail(uid: 'uid')));
      },
      act: (bloc) => bloc.getInspection('iId'),
      expect: () => [isA<InspectionItem>()]);
  blocTest<InspectionCubit, InspectionState>(
      'given authentication service can get user detail. '
      'when get user role from Authentication service. '
      'when user role is HOMEOWNER ONLY'
      'then return InspectionLoaded.',
      build: () => InspectionCubit(),
      setUp: () {
        final MockUserDetail mockUser = MockUserDetail();
        when(authenticationService.getCurrentUser())
            .thenAnswer((_) => Future.value(mockUser));
        when(memberService.getUserRoles(mockUser.uid))
            .thenAnswer((_) => Future.value([Roles.homeowner]));
        when(memberService.getInspectionList(mockUser.uid))
            .thenAnswer((realInvocation) => Future.value(['iId1']));
        when(inpsectionService.getInspectionById('iId1')).thenAnswer((_) =>
            Future.value(Inspection(
                propertyId: 'pId',
                startTime: DateTime(2011, 1, 1, 1, 1),
                endTime: DateTime(2011, 1, 2, 3, 4),
                createdBy: 'uid')));
        when(memberService.getMemberProperties(mockUser.uid))
            .thenAnswer((realInvocation) => Future.value(['pId1']));

        when(propertyService.getProperty('pId1')).thenAnswer((_) =>
            Future.value(Property(
                id: 'pId1',
                type: PropertyTypes.house,
                name: 'mock name',
                price: Price(currency: Currency.aud, rentPrice: 1000),
                description: 'mock description',
                address: const AddressDetail(
                    streetName: 'streetName',
                    streetNo: 'streetNo',
                    postcode: '3172',
                    suburb: 'suburb',
                    state: AustraliaStates.act),
                additionalDetail: const AdditionalDetail(),
                photos: ['photo1'],
                minimumRentPeriod: MinimumRentPeriod.eighteenMonths,
                location: const GeoPoint(90.0, 90.0),
                availableDate: Timestamp.now(),
                ownerUid: 'oid')));
      },
      act: (bloc) => bloc.getUserRole(),
      expect: () => [isA<InspectionLoaded>()]);
}
