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
  PropertyService,
  QuerySnapshot,
  Query
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
  MockQuerySnapshot<Map<String, dynamic>> mockQuerySnapshot = MockQuerySnapshot();
  MockQuery<Map<String, dynamic>> mockQuery = MockQuery();
  Property propertySample = Property(    
        availableDate: Timestamp(200,200),
        type: PropertyTypes.apartment,
        name: "mock name",
        price: Price(currency: Currency.aud, rentPrice: 3000),
        description: "mock description",
        address: AddressDetail(streetName: "mock streetname", streetNo: "streetNo", postcode: 3000, suburb: "suburb", state: AustraliaStates.nsw),
        additionalDetail: const AdditionalDetail(
            additional: [], bedrooms: 3, bathrooms: 3, parkings: 3),
        photos: [],
        minimumRentPeriod: MinimumRentPeriod.sixMonths, country: CountryCode.au, createdTime: Timestamp(200,200), location:const GeoPoint(90, 90));
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
    reset(mockQuerySnapshot);
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
      'given get property with valid property id, when user get all properties, then return a list of property',
      () async {

    when(mockDocumentSnapshot.exists).thenAnswer((realInvocation) => true);
    when(mockCollectionReference.limit(20)).thenAnswer((realInvocation) => mockQuery);
    when(mockQuery.get(any)).thenAnswer((realInvocation) => Future.value(mockQuerySnapshot) );
    when(mockQuerySnapshot.docs).thenAnswer((realInvocation) => [
      
    ]);
    StorageService storageService = StorageService();
    final result = storageService.property.getAllProperties();
    expect(result, isA<Future<List<Property>?>>());
  });

  test(
      'given user want to get one property, when user get one property by property id, then return property object',
      () async {
    when(mockDocumentSnapshot.exists).thenAnswer((realInvocation) => true);
    when(mockDocumentSnapshot.data()).thenAnswer((realInvocation) => propertySample.convertObjectToMap());
    StorageService storageService = StorageService();
    final result = await storageService.property.getProperty("test id");
    expect(result, isA<Property>());
  });

  test('verify API calls when save property', () async {
    StorageService storageService = StorageService();
    await storageService.property.saveProperty(propertySample);

    verify(mockFirebaseFirestore.collection('properties')).called(1);
    verify(mockCollectionReference.doc()).called(1);
    verify(mockDocumentReference.set(
      propertySample.convertObjectToMap()
    )).called(1);
  });
}
