import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'property_storage_service_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  FirebaseStorage,
  CollectionReference,
  DocumentReference,
  DocumentSnapshot,
  Property,
  StorageService,
  QuerySnapshot,
  Query
])
void main() {
  final MockFirebaseFirestore firestore = MockFirebaseFirestore();
  MockCollectionReference<Map<String, dynamic>> collectionReference =
      MockCollectionReference();
  MockDocumentReference<Map<String, dynamic>> documentReference =
      MockDocumentReference();
  MockDocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      MockDocumentSnapshot();
  MockQuerySnapshot<Map<String, dynamic>> querySnapshot = MockQuerySnapshot();
  MockQuery<Map<String, dynamic>> query = MockQuery();
  final MockFirebaseStorage storage = MockFirebaseStorage();

  Property propertySample = Property(
      availableDate: Timestamp(200, 200),
      type: PropertyTypes.apartment,
      name: 'mock name',
      price: Price(currency: Currency.aud, rentPrice: 3000),
      description: 'mock description',
      address: const AddressDetail(
          streetName: 'mock streetname',
          streetNo: 'streetNo',
          postcode: '3000',
          suburb: 'suburb',
          state: AustraliaStates.nsw),
      additionalDetail: const AdditionalDetail(
          additional: [], bedrooms: 3, bathrooms: 3, parkings: 3),
      photos: [],
      minimumRentPeriod: MinimumRentPeriod.sixMonths,
      country: CountryCode.au,
      createdTime: Timestamp(200, 200),
      location: const GeoPoint(90, 90),
      ownerUid: 'uid');
  setUpAll(() async {
    StorageService.firestore = firestore;
    StorageService.storage = storage;
    await HatSpaceStrings.load(const Locale.fromSubtags(languageCode: 'en'));
  });

  setUp(() {
    when(firestore.collection(any))
        .thenAnswer((realInvocation) => collectionReference);
    when(collectionReference.doc(any))
        .thenAnswer((realInvocation) => documentReference);
    when(documentReference.get(any))
        .thenAnswer((realInvocation) => Future.value(documentSnapshot));
  });

  tearDown(() {
    reset(firestore);
    reset(storage);
    reset(collectionReference);
    reset(documentReference);
    reset(documentSnapshot);
    reset(querySnapshot);
    reset(query);
  });

  test(
      'given property does not exist, when getProperty, then return null value',
      () async {
    when(documentSnapshot.exists).thenAnswer((realInvocation) => false);

    StorageService storageService = StorageService();

    final result = await storageService.property.getProperty('propId');

    expect(result, isNull);
  });

  test('given user roles data is null, when getProperty, then return null',
      () async {
    when(documentSnapshot.exists).thenAnswer((realInvocation) => true);
    when(documentSnapshot.data()).thenAnswer((realInvocation) => null);

    StorageService storageService = StorageService();

    final result = await storageService.property.getProperty('property id');

    expect(result, isNull);
  });

  test(
      'given get property with valid property id, when user get all properties, then return a list of property',
      () async {
    when(documentSnapshot.exists).thenAnswer((realInvocation) => true);
    when(collectionReference.limit(20)).thenAnswer((realInvocation) => query);
    when(query.get(any))
        .thenAnswer((realInvocation) => Future.value(querySnapshot));
    when(querySnapshot.docs).thenAnswer((realInvocation) => []);
    StorageService storageService = StorageService();
    final result = storageService.property.getAllProperties();
    expect(result, isA<Future<List<Property>?>>());
  });

  test(
      'given user want to get one property, when user get one property by property id, then return property object',
      () async {
    when(documentSnapshot.exists).thenAnswer((realInvocation) => true);
    when(documentSnapshot.data())
        .thenAnswer((realInvocation) => propertySample.convertObjectToMap());
    StorageService storageService = StorageService();
    final result = await storageService.property.getProperty('test id');
    expect(result, isA<Property>());
  });

  test('verify API calls when save property', () async {
    when(documentReference.id).thenReturn('id');

    StorageService storageService = StorageService();
    await storageService.property.addProperty(propertySample);
    verify(firestore.collection('properties')).called(1);
    verify(collectionReference.doc()).called(1);
    verify(documentReference.set(propertySample.convertObjectToMap()))
        .called(1);
  });
}
