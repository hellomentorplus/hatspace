import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/models/permission/permission_service.dart';
import 'package:hatspace/models/permission/permission_status.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

part 'add_property_images_state.dart';

class AddPropertyImagesCubit extends Cubit<AddPropertyImagesState> {
  final HsPermissionService _permissionService =
      HsSingleton.singleton.get<HsPermissionService>();

  AddPropertyImagesCubit() : super(AddPropertyImagesInitial());

  void requestPhotoPermission() async {
    HsPermissionStatus status =
        await _permissionService.requestPhotoPermission();

    switch (status) {
      case HsPermissionStatus.granted:
      case HsPermissionStatus.limited:
        if (!isClosed) {
          emit(PhotoPermissionGranted());
        }
        break;
      case HsPermissionStatus.deniedForever:
        if (!isClosed) {
          emit(PhotoPermissionDeniedForever());
        }
        break;
      default:
        if (!isClosed) {
          emit(PhotoPermissionDenied());
        }
    }
  }
}