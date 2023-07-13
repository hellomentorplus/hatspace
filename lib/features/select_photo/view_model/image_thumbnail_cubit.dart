import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/models/photo/photo_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:photo_manager/photo_manager.dart';

part 'image_thumbnail_state.dart';

class ImageThumbnailCubit extends Cubit<ImageThumbnailState> {
  ImageThumbnailCubit() : super(ImageThumbnailInitial());

  final PhotoService _photoService = HsSingleton.singleton.get<PhotoService>();

  Future<void> createThumbnail(AssetEntity entity) async {
    final File? file = await entity.originFile;
    if (file == null) {
      if (!isClosed) {
        emit(ThumbnailError());
      }
      return;
    }

    final File thumbnail = await _photoService.createThumbnail(file);
    if (!isClosed) {
      emit(ThumbnailLoaded(
          thumbnail: thumbnail, width: entity.width, height: entity.height));
    }
  }
}
