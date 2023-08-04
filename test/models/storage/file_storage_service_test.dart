import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/models/storage/file_service/file_storage_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'file_storage_service_test.mocks.dart';

@GenerateMocks([FirebaseStorage, FirebaseFirestore, Reference, UploadTask])
void main() {
  final MockFirebaseFirestore firestore = MockFirebaseFirestore();
  final MockFirebaseStorage storage = MockFirebaseStorage();
  final MockReference reference = MockReference();
  final MockUploadTask uploadTask = MockUploadTask();

  setUpAll(() {
    StorageService.firestore = firestore;
    StorageService.storage = storage;
  });

  setUp(() {
    when(storage.ref(any)).thenReturn(reference);
  });

  tearDown(() {
    reset(firestore);
    reset(storage);
    reset(reference);
  });

  test('Verify API calls when push file to storage', () {
    when(reference.child(any)).thenReturn(reference);
    when(reference.putFile(any)).thenAnswer((realInvocation) => uploadTask);
    when(uploadTask.then(any, onError: anyNamed('onError')))
        .thenAnswer((realInvocation) => Future.value());

    final StorageService storageService = StorageService();
    final FileService fileService = storageService.files;

    fileService.uploadFile(
      folder: 'folder',
      path: 'path',
      onError: (value) {},
      onComplete: (value) {},
    );

    // create a child at properties/folder/path
    verify(reference.child('properties/folder/path')).called(1);
    // verify a file is pushed
    verify(reference.putFile(any)).called(1);
  });
}
