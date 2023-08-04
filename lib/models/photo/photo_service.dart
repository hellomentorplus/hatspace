import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:path_provider/path_provider.dart';

class PhotoService {
  Future<File> createThumbnail(File original, {int targetBytes = 200}) async {
    // try to search for this thumbnail in thumbnail folder
    Directory directory = await getApplicationDocumentsDirectory();
    final String fileName = original.path.replaceAll('/', '_');
    final String compressFilePath =
        '${directory.path}/thumbnail/$targetBytes/$fileName';
    File compressedFile = File(compressFilePath);

    if (compressedFile.existsSync() && compressedFile.lengthSync() > 0) {
      return compressedFile;
    }

    if (compressedFile.existsSync()) {
      // file length is 0, remove it
      compressedFile.deleteSync();
    }

    compressedFile.createSync(recursive: true);

    try {
      final int imageBytes = original.lengthSync();

      int percentage = (targetBytes * 100 * 1024) ~/ imageBytes;

      if (percentage < 100) {
        compressedFile = await FlutterNativeImage.compressImage(original.path,
            percentage: percentage);

        final int compressedBytes = compressedFile.lengthSync();

        if (compressedBytes < 10) {
          compressedFile = original;
        }
      } else {
        compressedFile = original;
      }
      // move compressed file to thumbnail folder
      compressedFile = compressedFile.copySync(compressFilePath);

      return compressedFile;
    } catch (e) {
      debugPrint('Error ${e.toString()}');
    }
    return original;
  }
}
