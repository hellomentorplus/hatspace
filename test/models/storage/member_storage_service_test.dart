import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'member_storage_service_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  FirebaseStorage,
  CollectionReference,
  DocumentReference,
  DocumentSnapshot
])
void main() {
  final MockFirebaseFirestore firestore = MockFirebaseFirestore();
  final MockCollectionReference<Map<String, dynamic>> collectionReference =
      MockCollectionReference();
  final MockDocumentReference<Map<String, dynamic>> documentReference =
      MockDocumentReference();
  final MockDocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      MockDocumentSnapshot();
  final MockFirebaseStorage storage = MockFirebaseStorage();

  setUpAll(() {
    StorageService.firestore = firestore;
    StorageService.storage = storage;
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
    reset(collectionReference);
    reset(documentReference);
    reset(documentSnapshot);
  });

  test(
      'given user roles does not exist, when getUserRoles, then return empty list',
      () async {
    when(documentSnapshot.exists).thenAnswer((realInvocation) => false);

    StorageService storageService = StorageService();

    final result = await storageService.member.getUserRoles('uid');

    expect(result.isEmpty, isTrue);
  });

  test(
      'given user roles data is null, when getUserRoles, then return empty list',
      () async {
    when(documentSnapshot.exists).thenAnswer((realInvocation) => true);
    when(documentSnapshot.data()).thenAnswer((realInvocation) => null);

    StorageService storageService = StorageService();

    final result = await storageService.member.getUserRoles('uid');

    expect(result.isEmpty, isTrue);
  });

  test(
      'given user roles data does not contain roles, when getUserRoles, then return empty list',
      () async {
    when(documentSnapshot.exists).thenAnswer((realInvocation) => true);
    when(documentSnapshot.data()).thenAnswer((realInvocation) => {});

    StorageService storageService = StorageService();

    final result = await storageService.member.getUserRoles('uid');

    expect(result.isEmpty, isTrue);
  });

  test(
      'given user roles data is invalid, when getUserRoles, then return empty list',
      () async {
    when(documentSnapshot.exists).thenAnswer((realInvocation) => true);
    when(documentSnapshot.data())
        .thenAnswer((realInvocation) => {'roles': 'this is invalid data'});

    StorageService storageService = StorageService();

    final result = await storageService.member.getUserRoles('uid');

    expect(result.isEmpty, isTrue);
  });

  test(
      'given user roles data is valie, when getUserRoles, then return list of Roles',
      () async {
    when(documentSnapshot.exists).thenAnswer((realInvocation) => true);
    when(documentSnapshot.data()).thenAnswer((realInvocation) => {
          'roles': ['tenant', 'homeowner']
        });

    StorageService storageService = StorageService();

    final result = await storageService.member.getUserRoles('uid');

    expect(result.isEmpty, isFalse);
    expect(result.length, 2);
    expect(result.first, Roles.tenant);
    expect(result.last, Roles.homeowner);
  });

  test('verify API calls when saveUserRoles', () async {
    StorageService storageService = StorageService();

    await storageService.member
        .saveUserRoles('uid', {Roles.tenant, Roles.homeowner});

    verify(firestore.collection('members')).called(1);
    verify(collectionReference.doc('uid')).called(1);
    verify(documentReference.set({
      'roles': ['tenant', 'homeowner']
    })).called(1);
  });

  test('verify API calls when saveMember', () async {
    StorageService storageService = StorageService();
    await storageService.member
        .saveMember('uid', {Roles.homeowner}, 'displayName');
    verify(firestore.collection('members')).called(1);
    verify(collectionReference.doc('uid')).called(1);
    verify(documentReference.set({
      'displayName': 'displayName',
      'roles': ['homeowner'],
    }, any))
        .called(1);
  });
}
