import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';

part 'select_photo_state.dart';

class SelectPhotoCubit extends Cubit<SelectPhotoState> {
  SelectPhotoCubit() : super(SelectPhotoInitial());

  List<AssetEntity> _galleryList = [];

  Future<void> loadPhotos() async {
    final totalCount =
        await PhotoManager.getAssetCount(type: RequestType.image);

    _galleryList = await PhotoManager.getAssetListRange(
        type: RequestType.image, start: 0, end: totalCount);

    _galleryList
        .removeWhere((element) => element.width == 0 || element.height == 0);

    emit(PhotosLoaded(_galleryList));
  }

  void closeSelectPhotoScreen() {
    emit(CloseSelectPhotoScreen());
  }
}
