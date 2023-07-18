import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

import '../../../../models/photo/photo_service.dart';

part 'add_property_image_selected_state.dart';

class AddPropertyImageSelectedCubit extends Cubit<AddPropertyImageSelectedState> {
  AddPropertyImageSelectedCubit() : super(AddPropertyImageSelectedInitial());

  final PhotoService _photoService = HsSingleton.singleton.get<PhotoService>();

  void onPhotosSelected(List<String>? photos) async {
    if (photos == null) {
      return;
    }

    if (photos.isEmpty) {
      return;
    }

    // there are photos selected
    emit(PhotoSelectionReturned(paths: photos));
  }
}