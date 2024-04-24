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
      'given user roles data is valid, when getUserRoles, then return list of Roles',
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
      'roles': ['tenant', 'homeowner'],
    }, any))
        .called(1);
  });

  test('verify API calls when saveUserRoles', () async {
    StorageService storageService = StorageService();
    await storageService.member.saveUserRoles('uid', {Roles.homeowner});
    verify(firestore.collection('members')).called(1);
    verify(collectionReference.doc('uid')).called(1);
    verify(documentReference.set({
      'roles': ['homeowner'],
    }, any))
        .called(1);
  });

  group('verify API calls when saveNameAndAvatar', () {
    test(
        'given user display name and avatar are available,'
        'when saveNameAndAvatar without update,'
        'then do not override', () async {
      when(documentSnapshot.exists).thenReturn(true);
      when(documentSnapshot.data())
          .thenReturn({'displayName': 'aa', 'avatar': 'bb'});
      StorageService storageService = StorageService();
      await storageService.member
          .saveNameAndAvatar('uid', 'displayName', 'avatar');

      // 1 time when get display name
      // 1 time when get avatar
      // 1 time when override
      verify(firestore.collection('members')).called(3);
      verify(collectionReference.doc('uid')).called(3);

      verifyNever(documentReference
          .set({'displayName': 'displayName', 'avatar': 'avatar'}, any));
      verify(documentReference.set({'displayName': 'aa', 'avatar': 'bb'}, any))
          .called(1);
    });

    test(
        'given user display name and avatar are available,'
        'when saveNameAndAvatar with update,'
        'then override', () async {
      when(documentSnapshot.exists).thenReturn(true);
      when(documentSnapshot.data())
          .thenReturn({'displayName': 'aa', 'avatar': 'bb'});
      StorageService storageService = StorageService();
      await storageService.member
          .saveNameAndAvatar('uid', 'displayName', 'avatar', update: true);

      // 1 time when override
      verify(firestore.collection('members')).called(1);
      verify(collectionReference.doc('uid')).called(1);

      verify(documentReference
              .set({'displayName': 'displayName', 'avatar': 'avatar'}, any))
          .called(1);
      verifyNever(
          documentReference.set({'displayName': 'aa', 'avatar': 'bb'}, any));
    });

    test(
        'given user display name and avatar are unchanged,'
        'when saveNameAndAvatar without update,'
        'then override', () async {
      when(documentSnapshot.exists).thenReturn(true);
      when(documentSnapshot.data())
          .thenReturn({'displayName': 'displayName', 'avatar': 'avatar'});
      StorageService storageService = StorageService();
      await storageService.member
          .saveNameAndAvatar('uid', 'displayName', 'avatar');

      // 1 time when get display name
      // 1 time when get avatar
      verify(firestore.collection('members')).called(2);
      verify(collectionReference.doc('uid')).called(2);

      verifyNever(documentReference
          .set({'displayName': 'displayName', 'avatar': 'avatar'}, any));
    });

    test(
        'given user want to add property'
        'When addMemberProperties'
        'Then add new property to array list of properties', () async {
      when(documentSnapshot.exists).thenReturn(true);
      when(documentSnapshot.data()).thenReturn({});
      StorageService storageService = StorageService();
      await storageService.member.addMemberProperties('uid', 'propertyId');
      verify(firestore.collection('members')).called(2);
    });

    test(
        'given user want get phone number'
        'When getMemberPhoneNumber'
        'verify phoneNumber', () async {
      when(documentSnapshot.exists).thenReturn(true);
      when(documentSnapshot.data()).thenReturn({
        'phone': {'countryCode': '+61', 'numberKey': '1234567890'}
      });
      StorageService storageService = StorageService();
      final result = await storageService.member.getMemberPhoneNumber('uid');
      verify(firestore.collection('members')).called(1);
      expect(result!.countryCode, PhoneCode.au);
      expect(result.phoneNumber, '1234567890');
    });

    test(
        'given user save get phone number'
        'When savePhoneNumber'
        'verify phoneNumber', () async {
      when(documentSnapshot.exists).thenReturn(true);
      when(documentSnapshot.data()).thenReturn({});
      StorageService storageService = StorageService();
      await storageService.member.savePhoneNumberDetail('uid',
          PhoneNumber(countryCode: PhoneCode.au, phoneNumber: '1234567890'));
      verify(firestore.collection('members')).called(1);
      verify(collectionReference.doc('uid')).called(1);
      verify(documentReference.set({
        'phone': {'countryCode': '+61', 'numberKey': '1234567890'}
      }, any))
          .called(1);
    });

    test(
        'given user add new booked inspection'
        'when addBookedInspection'
        'verify update inspection list', () async {
      when(documentSnapshot.exists).thenReturn(true);
      when(documentSnapshot.data()).thenReturn({});
      StorageService storageService = StorageService();
      await storageService.member.addBookedInspection('id', 'uid');
      verify(firestore.collection('members')).called(1);
      verify(collectionReference.doc('uid')).called(1);
      verify(documentReference.update({
        'inspectionList': FieldValue.arrayUnion(['id'])
      })).called(1);
    });
    test('verify getUserDetailById api', () async {
      when(documentSnapshot.exists).thenReturn(true);
      when(documentSnapshot.data()).thenAnswer((realInvocation) => {
            'displayName': 'mock display name',
            'avatar': 'mock avatar',
          });
      StorageService storageService = StorageService();
      final result = await storageService.member.getUserDetail('uid');
      expect(result!.displayName, 'mock display name');
      expect(result.avatar, 'mock avatar');
    });
  });
}
