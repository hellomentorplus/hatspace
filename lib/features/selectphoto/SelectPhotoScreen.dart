import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';

class SelectPhotoScreen extends StatefulWidget {
  const SelectPhotoScreen({super.key});

  @override
  _SelectPhotoScreenState createState() => _SelectPhotoScreenState();
}

class _SelectPhotoScreenState extends State<SelectPhotoScreen> {
  List<File> images = [];
  int currentPage = 0;
  int perPage = 40;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadPhotos(page: currentPage, perPage: perPage);
    _scrollController.addListener(_scrollListener);
  }

  Future<File?> compressImageWithFlutterImageCompress(File imageFile) async {
    try {
      bool isImageTooLarge = await isLargerThan5MB(imageFile);
      if (!isImageTooLarge) {
        return imageFile;
      }

      Uint8List? compressedFile = await FlutterImageCompress.compressWithFile(
        imageFile.absolute.path,
        quality: 80,
      );

      if (compressedFile == null) {
        return null;
      }

      File? file = await saveImageDataToFile(compressedFile);

      if (file != null) {
        List<int> resultBytes = await file.readAsBytes();
        double result = resultBytes.length / (1024 * 1024);
        List<int> imageBytes = await imageFile.readAsBytes();
        double initialSize = imageBytes.length / (1024 * 1024);
        print('xxx - origional =${initialSize} MB, result=${result}MB\n');
      }
      return file;
    } catch (e) {
      print('xxx - compressImageWithFlutterImageCompress e=${e}\n');
      return null;
    }
  }

  Future<File?> saveImageDataToFile(Uint8List imageData) async {
    try {
      final Directory cacheDir = await getTemporaryDirectory();
      final String filePath = '${cacheDir.path}/image.jpg';
      final File imageFile = File(filePath);
      await imageFile.writeAsBytes(imageData);
      return imageFile;
    } catch (e) {
      print('xxx - saveImageDataToFile e=${e}\n');
      return null;
    }
  }

  Future<void> deleteAllFilesInCacheDirectory() async {
    try {
      final Directory cacheDir = await getTemporaryDirectory();
      final List<FileSystemEntity> files = cacheDir.listSync();
      for (final file in files) {
        if (file is File) {
          await file.delete();
        }
      }
    } catch (e) {
      print('Error deleting cache files: $e');
    }
  }

  Future<File?> compressImageWithFlutterNativeImage(File imageFile) async {
    try {
      bool isImageTooLarge = await isLargerThan5MB(imageFile);
      if (!isImageTooLarge) {
        return imageFile;
      }

      File compressedFile = await FlutterNativeImage.compressImage(
        imageFile.path,
        quality: 80,
      );

      List<int> compressedBytes = await compressedFile.readAsBytes();
      double result = compressedBytes.length / (1024 * 1024);
      List<int> imageBytes = await imageFile.readAsBytes();
      double initialSize = imageBytes.length / (1024 * 1024);
      print('xxx - origional =${initialSize} MB, result=${result}MB\n');
      return compressedFile;
    } catch (e) {
      print('xxx - compressImageWithFlutterNativeImage e=${e}\n');
      return null;
    }
  }

  Future<bool> isLargerThan5MB(File imageFile) async {
    double maxSizeBytes = 5.0; // 5MB
    List<int> imageBytes = await imageFile.readAsBytes();
    double initialSize = imageBytes.length / (1024 * 1024);

    return initialSize > maxSizeBytes;
  }

  Future<void> loadPhotos({int page = 0, int perPage = 40}) async {
    final List<AssetEntity> galleryList = await PhotoManager.getAssetListPaged(
      type: RequestType.image,
      page: page,
      pageCount: perPage,
    );
    print('xxx - galleryList size=${galleryList.length}\n');

    final List<File> compressedAssets = [];
    File? compressedFile;
    for (final asset in galleryList) {
      final file = await asset.file;
      if (file != null) {
        compressedFile = await compressImageWithFlutterNativeImage(file);
        // compressedFile = await compressImageWithFlutterImageCompress(file);
        if (compressedFile != null) {
          bool isImageTooLarge = await isLargerThan5MB(compressedFile);
          if (!isImageTooLarge) {
            compressedAssets.add(compressedFile);
          }
        }
      }
    }

    setState(() {
      print('xxx - compressedAssets size=${compressedAssets.length}\n');
      images.addAll(compressedAssets);
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      currentPage++;
      print('currentPage=$currentPage');
      loadPhotos(page: currentPage, perPage: perPage);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Manager Demo'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Number of items per row
        ),
        controller: _scrollController,
        itemCount: images.length + 1, // Add 1 for the loading indicator
        itemBuilder: (context, index) {
          if (index < images.length) {
            final image = images[index];
            return GridTile(
              child: Image.file(
                image, // Display image from file
                fit: BoxFit.cover,
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
