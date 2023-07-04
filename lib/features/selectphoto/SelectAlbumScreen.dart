import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class SelectAlbumScreen extends StatefulWidget {
  const SelectAlbumScreen({super.key});

  @override
  _SelectAlbumScreenState createState() => _SelectAlbumScreenState();
}

class _SelectAlbumScreenState extends State<SelectAlbumScreen> {
  List<AssetPathEntity> albums = [];
  int currentPage = 0;
  int perPage = 10;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadAlbums(page: currentPage, perPage: perPage);
    _scrollController.addListener(_scrollListener);
  }

  Future<void> loadAlbums({int page = 1, int perPage = 10}) async {
    final albums = await PhotoManager.getAssetPathList(type: RequestType.image);

    List<AssetPathEntity> nonEmptyAlbums = [];
    for (var album in albums) {
      List<AssetEntity> assets = await album.getAssetListRange(
        start: 0,
        end: perPage - 1,
      );
      if (assets.isNotEmpty) {
        nonEmptyAlbums.add(album);
      }
    }

    setState(() {
      this.albums.addAll(nonEmptyAlbums);
    });
  }


  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      currentPage++;
      print('currentPage=$currentPage');
      loadAlbums(page: currentPage, perPage: perPage);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<AssetEntity> getFirstImageFromAlbum(AssetPathEntity album) async {
    // Set the page size to 1 to fetch only one asset
    final List<AssetEntity> assets = await album.getAssetListPaged(page: 1, size: 1);
    return assets.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Manager Demo'),
      ),
      body: GridView.count(
        crossAxisCount: 2, // Number of items per row
        children: albums.map((album) {
          return Column(
            children: [
              FutureBuilder<AssetEntity>(
                future: getFirstImageFromAlbum(album),
                builder: (BuildContext context, AsyncSnapshot<AssetEntity> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                    return Image(
                      image: AssetEntityImageProvider(snapshot.data!),
                      fit: BoxFit.fill,
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              SizedBox(height: 8),
              Text(
                album.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }



}
