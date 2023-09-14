import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  final FirebaseStorage _storage;

  FileService(FirebaseStorage storage) : _storage = storage;

  final String _propertyPhotos = 'properties';
  final String _rentalForms = 'rental_forms';

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
  
  Future<void> downloadFile(
      ValueChanged<String> onSuccess,
  {VoidCallback? onStart, VoidCallback? onCancel, VoidCallback? onError, ValueChanged<int>? onDownloading, VoidCallback? onPaused}
      ) async {
    onStart?.call();

    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final filePath = '${appDocDir
          .path}/$_rentalForms/RentalApplicationForm.pdf';
      final file = File(filePath);

      print('SUESI filePath $filePath');
      if (file.existsSync()) {
        onSuccess(filePath);
        return;
      }

      file.createSync(recursive: true);

      final Reference storageRef = _storage.ref();

      final formRef = storageRef.child(
          '$_rentalForms/RentalApplicationForm.pdf');

      final downloadTask = formRef.writeToFile(file);
      downloadTask.snapshotEvents.listen((taskSnapshot) {
        print('SUESI - taskSnapshot.totalBytes ${taskSnapshot.totalBytes} => state ${taskSnapshot.state}');
        switch (taskSnapshot.state) {
          case TaskState.running:
            onDownloading?.call(taskSnapshot.totalBytes);
            break;
          case TaskState.paused:
            onPaused?.call();
            break;
          case TaskState.success:
            onSuccess(filePath);
            break;
          case TaskState.canceled:
            onCancel?.call();
            break;
          case TaskState.error:
            onError?.call();
            break;
        }
      });
    } catch (e) {

    }
  }
}
