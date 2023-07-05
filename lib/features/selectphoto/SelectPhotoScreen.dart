import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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

  Future<File> compressImage(File imageFile) async {
    double maxSizeBytes = 5.0; // 5MB

    List<int> imageBytes = await imageFile.readAsBytes();
    double initialSize = imageBytes.length / (1024 * 1024);

    if (initialSize <= maxSizeBytes) {
      // No need to compress if the image is already smaller than 5MB
      return imageFile;
    }

    print('currentPage - a > 5MB ${initialSize} MB\n');

    Uint8List? compressedBytes = await FlutterImageCompress.compressWithFile(
      imageFile.path,
      quality: 98,
    );

    imageBytes = compressedBytes!.toList();

    File a =  File(imageFile.path)..writeAsBytesSync(imageBytes);
    print('currentPage - a=${await a.length() / (1024*1024)} MB\n');

    return a;
  }

  Future<void> loadPhotos({int page = 0, int perPage = 40}) async {
    final List<AssetEntity> galleryList = await PhotoManager.getAssetListPaged(
      type: RequestType.image,
      page: page,
      pageCount: perPage,
    );
    print('currentPage - galleryList size=${galleryList.length}\n');

    final List<File> compressedAssets = [];

    await Future.wait(galleryList.map((asset) async {
      final file = await asset.file;
      if (file != null) {
        final compressedFile = await compressImage(file);
        print('currentPage - compressedSize=${await compressedFile.length() / (1024*1024)} MB\n');
        compressedAssets.add(compressedFile);
      }
    }).toList());

    setState(() {
      print('currentPage - compressedAssets size=${compressedAssets.length}\n');
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
