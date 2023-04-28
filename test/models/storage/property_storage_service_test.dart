import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/models/storage/member_service/property_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'property_storage_service_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  DocumentSnapshot,
  AdditionalDetail,
  Property,
  StorageService,
  PropertyService
])
void main() {
  MockFirebaseFirestore mockFirebaseFirestore = MockFirebaseFirestore();
  MockCollectionReference<Map<String, dynamic>> mockCollectionReference =
      MockCollectionReference();
  MockDocumentReference<Map<String, dynamic>> mockDocumentReference =
      MockDocumentReference();
  MockDocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot =
      MockDocumentSnapshot();
  MockAdditionalDetail mockAdditionalDetail = MockAdditionalDetail();
  MockProperty mockProperty = MockProperty();
  MockStorageService mockStorageService = MockStorageService();
  MockPropertyService mockPropertyService = MockPropertyService();
  setUpAll(() {
    StorageService.firestore = mockFirebaseFirestore;
  });

  setUp(() {
    when(mockFirebaseFirestore.collection(any))
        .thenAnswer((realInvocation) => mockCollectionReference);
    when(mockCollectionReference.doc(any))
        .thenAnswer((realInvocation) => mockDocumentReference);
    when(mockDocumentReference.get(any))
        .thenAnswer((realInvocation) => Future.value(mockDocumentSnapshot));
  });

  tearDown(() {
    reset(mockFirebaseFirestore);
    reset(mockCollectionReference);
    reset(mockDocumentReference);
    reset(mockDocumentSnapshot);
  });

  test(
      'given property does not exist, when getProperty, then return null value',
      () async {
    when(mockDocumentSnapshot.exists).thenAnswer((realInvocation) => false);

    StorageService storageService = StorageService();

    final result = await storageService.property.getProperty("propId");

    expect(result, isNull);
  });

  test('given user roles data is null, when getProperty, then return null',
      () async {
    when(mockDocumentSnapshot.exists).thenAnswer((realInvocation) => true);
    when(mockDocumentSnapshot.data()).thenAnswer((realInvocation) => null);

    StorageService storageService = StorageService();

    final result = await storageService.property.getProperty('property id');

    expect(result, isNull);
  });

  test(
      'given get property with valid property id, when user wants to getPropertyAdditionalDetail, then return additional detail of a property',
      () async {
    StorageService storageService = StorageService();
    final result = storageService.property.getPropertyAdditionalDetials({
      Property.propPropDetails: {
        AdditionalDetail.bathroomKey: 3,
        AdditionalDetail.bedroomKey: 3,
        AdditionalDetail.parkingKey: 3,
        AdditionalDetail.additionalKey: []
      }
    });
    expect(result.bathrooms, 3);
    expect(result.bedrooms, 3);
    expect(result.parkings, 3);
    expect(result.additional, []);
  });

  test(
      'given user roles data is valie, when getUserRoles, then return list of Roles',
      () async {
    when(mockDocumentSnapshot.exists).thenAnswer((realInvocation) => true);
    when(mockDocumentSnapshot.data()).thenAnswer((realInvocation) => {
        Property.propAddress: "mock address",
      Property.propDescription: "mock description",
      Property.propMinimumRentPeriod: MinimumRentPeriod.sixMonths.text,
      Property.propName: "mock name",
      Property.propPhoto: [],
      Property.propPrice: {
        Price.currencyKey : Currency.AUD.name,
        Price.rentPriceKey : 3000
      },
      Property.propPropDetails: {
        AdditionalDetail.bathroomKey: 3,
        AdditionalDetail.bedroomKey:3,
        AdditionalDetail.parkingKey: 3,
        AdditionalDetail.additionalKey: []
      },
      Property.propType : []
        });
    StorageService storageService = StorageService();
    final result = await storageService.property.getProperty("test id");
    expect(result, isA<Property>());
  });

  test('verify API calls when save property', () async {
    StorageService storageService = StorageService();
    await storageService.property.saveProperty(
      Property(listType: [PropertyTypes.apartment],
       name: "mock name", price: Price(
        currency: Currency.AUD,
        rentPrice: 3000
       ),
        description: "mock description", 
        address: "mock address", 
        additionalDetail:const AdditionalDetail(additional: [],bedrooms: 3,bathrooms: 3,parkings: 3), 
        photos: [],
         minimumRentPeriod: MinimumRentPeriod.sixMonths)
    );

    verify(mockFirebaseFirestore.collection('properties')).called(1);
    verify(mockCollectionReference.doc()).called(1);
    verify(mockDocumentReference.set({
       Property.propAddress: "mock address",
      Property.propDescription: "mock description",
      Property.propMinimumRentPeriod: MinimumRentPeriod.sixMonths.text,
      Property.propName: "mock name",
      Property.propPhoto: [],
      Property.propPrice: {
        Price.currencyKey : Currency.AUD.name,
        Price.rentPriceKey : 3000
      },
      Property.propPropDetails: {
        AdditionalDetail.bathroomKey: 3,
        AdditionalDetail.bedroomKey:3,
        AdditionalDetail.parkingKey: 3,
        AdditionalDetail.additionalKey: []
      },
      Property.propType : [PropertyTypes.apartment.name]
        }
    )).called(1);
  });
}
