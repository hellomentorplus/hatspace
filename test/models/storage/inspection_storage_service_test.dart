import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/data/inspection.dart';
import 'package:hatspace/models/storage/member_service/inspection_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'inspection_storage_service_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  FirebaseStorage,
  CollectionReference,
  DocumentReference,
  DocumentSnapshot,
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
    when(firestore.collection(any))
        .thenAnswer((realInvocation) => collectionReference);
    when(collectionReference.doc(any))
        .thenAnswer((realInvocation) => documentReference);
    when(documentReference.get(any))
        .thenAnswer((realInvocation) => Future.value(documentSnapshot));
  });
  test('verify API calls when addInspection', () async {
    StorageService storageService = StorageService();
    Inspection mockInspection = Inspection(
        propertyId: 'pid',
        startTime: DateTime(2011, 2, 3, 4, 5),
        endTime: DateTime(2011, 2, 3, 4, 5),
        createdBy: 'uid');
    when(documentReference.id).thenReturn('id');
    await storageService.inspection.addInspection(mockInspection);
    verify(firestore.collection('inspections')).called(1);
    verify(collectionReference.doc()).called(1);
    verify(documentReference.set(mockInspection.convertToMap(), any)).called(1);
  });
}
