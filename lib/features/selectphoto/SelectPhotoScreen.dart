import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class SelectPhotoScreen extends StatefulWidget {
  const SelectPhotoScreen({super.key});

  @override
  _SelectPhotoScreenState createState() => _SelectPhotoScreenState();
}

class _SelectPhotoScreenState extends State<SelectPhotoScreen> {
  List<AssetPathEntity> albums = [];
  List<AssetEntity> images = [];
  int currentPage = 0;
  int perPage = 40;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadPhotos(page: currentPage, perPage: perPage);
    _scrollController.addListener(_scrollListener);
  }

  Future<void> loadPhotos({int page = 0, int perPage = 40}) async {
    final galleryList = await PhotoManager.getAssetListPaged(
      type: RequestType.image,
      page: page,
      pageCount: perPage,
    );

    final filteredImages = await Future.wait(galleryList.map((asset) async {
      final file = await asset.file;
      if (file != null) {
        final fileSize = await file.length();
        print('currentPage - fileSize=${fileSize / (1024 * 1024)} MB\n');
        return fileSize < 5 * 1024 * 1024; // Filter images less than 5MB
      }
      return false; // Handle null file
    }).toList());

    final filteredAssetList = galleryList.asMap().entries.where((entry) {
      final index = entry.key;
      return filteredImages[index];
    }).map((entry) => entry.value).toList();

    setState(() {
      images.addAll(filteredAssetList);
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
        itemCount: images.length,
        itemBuilder: (context, index) {
          if (index < images.length) {
            final image = images[index];
            return GridTile(
              child: FutureBuilder<File?>(
                future: image.file,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    final file = snapshot.data!;
                    return Image.file(
                      file, // Display image from file
                      fit: BoxFit.cover,
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
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
