import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FileService {
  final FirebaseStorage _storage;

  FileService(FirebaseStorage storage) : _storage = storage;

  final String _propertyPhotos = 'properties';

  Future<void> uploadFile(
      {required String folder,
      required String path,
      required ValueChanged<Exception> onError,
      required ValueChanged<String> onComplete}) async {
    // get filename
    final String fileName = path.split('/').last;

    final Reference storageRef = _storage.ref();

    // Create a child reference
    // photoRef now points to "images"
    final photoRef = storageRef.child('$_propertyPhotos/$folder/$fileName');

    try {
      await photoRef.putFile(File(path));
      final String url = await photoRef.getDownloadURL();
      onComplete(url);
    } on FirebaseException catch (e) {
      onError(e);
    }
  }
}
