import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/home/view_model/get_properties_cubit.dart';
import 'package:hatspace/models/storage/member_service/property_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_properties_cubit_test.mocks.dart';

@GenerateMocks([StorageService, PropertyService])
void main() {
  final MockStorageService storageService = MockStorageService();
  final PropertyService propertyService = MockPropertyService();

  setUpAll(() {
    HsSingleton.singleton.registerSingleton<StorageService>(storageService);

    /// Must have to specify this because when bloc uses storage service to get data,
    /// then the storage service will use this mock property service. Otherwise it will fail.
    when(storageService.property).thenReturn(propertyService);
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
      expect: () => [
            isA<GetPropertiesState>().having(
                (p0) => p0.isGettingPropertiesState,
                'Fetching properties',
                true),
            isA<GetPropertiesState>()
                .having(
                    (p0) => p0.isGetPropertiesFailed, 'Fetched failed', true)
                .having((p0) => p0.errorFetching, 'Fetched failed message',
                    'Failed to fetch properties')
          ]);

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
                  postcode: 6000,
                  suburb: 'suburb',
                  state: AustraliaStates.nsw,
                  unitNo: '12121'),
            ),
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
                  postcode: 6000,
                  suburb: 'suburb 1',
                  state: AustraliaStates.nsw,
                  unitNo: '121211'),
            ),
          ]));
    },
    act: (bloc) => bloc.getProperties(),
    expect: () => [
      isA<GetPropertiesState>().having(
          (p0) => p0.isGettingPropertiesState, 'Fetching properties', true),
      isA<GetPropertiesState>()
          .having((p0) => p0.properties.length, 'Properties length', 2)
          .having((p0) => p0.properties.first.name, 'Property Name', 'name')
          .having((p0) => p0.properties[1].name, 'Property Name', 'name 1')
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
      isA<GetPropertiesState>().having(
          (p0) => p0.isGettingPropertiesState, 'Fetching properties', true),
      isA<GetPropertiesState>()
          .having((p0) => p0.properties.length, 'Properties length', 0)
          .having(
              (p0) => p0.isGetPropertiesSucceed, 'Fetching properties', true),
    ],
  );

  blocTest<GetPropertiesCubit, GetPropertiesState>(
      'Given GetPropertiesCubit was just created. '
      'When user do nothing. '
      'Then state will be GetPropertiesInitialState.',
      build: () => GetPropertiesCubit(),
      verify: (bloc) {
        expect(bloc.state.isInitialState, true);
        expect(
            () => bloc.state.properties, throwsA(isA<TypeError>()));
        expect(
            () => bloc.state.errorFetching, throwsA(isA<TypeError>()));
        expect(
            () => (bloc.state as GetPropertiesSucceedState).properties, throwsA(isA<TypeError>()));
      });
}
