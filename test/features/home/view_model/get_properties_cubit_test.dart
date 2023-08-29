import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/home/view_model/get_properties_cubit.dart';
import 'package:hatspace/models/storage/member_service/member_storage_service.dart';
import 'package:hatspace/models/storage/member_service/property_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_properties_cubit_test.mocks.dart';

@GenerateMocks([StorageService, PropertyService, MemberService])
void main() {
  final MockStorageService storageService = MockStorageService();
  final MockPropertyService propertyService = MockPropertyService();
  final MockMemberService memberService = MockMemberService();

  setUpAll(() async {
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);

    /// Must have to specify this because when bloc uses storage service to get data,
    /// then the storage service will use this mock property service. Otherwise it will fail.
    when(storageService.property).thenReturn(propertyService);

    when(storageService.member).thenReturn(memberService);

    /// Must to enable localization because AustraliaStates has used HatSpaceStrings
    await HatSpaceStrings.load(const Locale.fromSubtags(languageCode: 'en'));
  });

  blocTest(
      'Given property service can not get list property from remote. '
      'When call getAllProperties. '
      'Then emit state with orders : GetPropertiesInitialState -> GettingPropertiesState -> GetPropertiesFailedState.',
      build: () => GetPropertiesCubit(),
      setUp: () {
        when(propertyService.getAllProperties())
            .thenThrow(Exception('Failed to fetch all properties'));
      },
      act: (bloc) => bloc.getProperties(),
      expect: () =>
          [isA<GettingPropertiesState>(), isA<GetPropertiesFailedState>()]);

  blocTest(
    'Given current state is initial state and propertyService return data successfully. '
    'When user call getAllProperties. '
    'Then emit state with orders : GetPropertiesInitialState -> GettingPropertiesState -> GetPropertiesSucceedState',
    build: () => GetPropertiesCubit(),
    setUp: () {
      when(propertyService.getAllProperties()).thenAnswer((_) => Future.value([
            Property(
                id: 'id',
                type: PropertyTypes.house,
                photos: [],
                minimumRentPeriod: MinimumRentPeriod.oneMonth,
                location: const GeoPoint(12, 23),
                availableDate: Timestamp(21312312312, 12312312),
                additionalDetail: const AdditionalDetail(
                    bedrooms: 1, bathrooms: 2, parkings: 3),
                name: 'name',
                price: Price(rentPrice: 3000),
                description: 'description',
                address: const AddressDetail(
                  streetName: 'streetName',
                  streetNo: 'streetNo',
                  postcode: '6000',
                  suburb: 'suburb',
                  state: AustraliaStates.nsw,
                  unitNo: '12121',
                ),
                ownerUid: 'uid'),
            Property(
                id: 'id',
                type: PropertyTypes.house,
                photos: [],
                minimumRentPeriod: MinimumRentPeriod.twelveMonths,
                location: const GeoPoint(12, 23),
                availableDate: Timestamp(21312312312, 12312312),
                additionalDetail: const AdditionalDetail(
                    bedrooms: 1, bathrooms: 2, parkings: 3),
                name: 'name 1',
                price: Price(rentPrice: 2000),
                description: 'description 1',
                address: const AddressDetail(
                    streetName: 'streetName 1',
                    streetNo: 'streetNo 1',
                    postcode: '6000',
                    suburb: 'suburb 1',
                    state: AustraliaStates.nsw,
                    unitNo: '121211'),
                ownerUid: 'uid'),
          ]));
      when(memberService.getMemberAvatar(any))
          .thenAnswer((realInvocation) => Future.value('avatar'));
      when(memberService.getMemberDisplayName(any))
          .thenAnswer((realInvocation) => Future.value('display name'));
    },
    act: (bloc) => bloc.getProperties(),
    expect: () => [
      isA<GettingPropertiesState>(),
      isA<GetPropertiesSucceedState>()
          .having((p0) => p0.propertyList.length, 'Properties length', 2)
          .having((p0) => p0.propertyList.first.name, 'Property Name 1', 'name')
          .having((p0) => p0.propertyList[1].name, 'Property Name 2', 'name 1')
    ],
  );

  blocTest<GetPropertiesCubit, GetPropertiesState>(
    'Given current state is initial state and propertyService return empty data. '
    'When user call getAllProperties. '
    'Then emit state with orders : GetPropertiesInitialState -> GettingPropertiesState -> GetPropertiesSucceedState',
    build: () => GetPropertiesCubit(),
    setUp: () {
      when(propertyService.getAllProperties())
          .thenAnswer((_) => Future.value([]));
    },
    act: (bloc) => bloc.getProperties(),
    expect: () => [
      isA<GettingPropertiesState>(),
      isA<GetPropertiesSucceedState>()
          .having((p0) => p0.propertyList.length, 'Properties length', 0)
    ],
  );

  blocTest<GetPropertiesCubit, GetPropertiesState>(
    'Given current state is initial state and propertyService return null. '
    'When user call getAllProperties. '
    'Then emit state with orders : GetPropertiesInitialState -> GettingPropertiesState -> GetPropertiesSucceedState',
    build: () => GetPropertiesCubit(),
    setUp: () {
      when(propertyService.getAllProperties())
          .thenAnswer((_) => Future.value(null));
    },
    act: (bloc) => bloc.getProperties(),
    expect: () => [
      isA<GettingPropertiesState>(),
      isA<GetPropertiesSucceedState>()
          .having((p0) => p0.propertyList.length, 'Properties length', 0)
    ],
  );

  blocTest<GetPropertiesCubit, GetPropertiesState>(
      'Given GetPropertiesCubit was just created. '
      'When user do nothing. '
      'Then state will be GetPropertiesInitialState.',
      build: () => GetPropertiesCubit(),
      verify: (bloc) {
        expect(bloc.state is GetPropertiesInitialState, true);
        expect(() => (bloc.state as GetPropertiesSucceedState).propertyList,
            throwsA(isA<TypeError>()));
      });
}
