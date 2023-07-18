import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/models/permission/permission_service.dart';
import 'package:hatspace/models/permission/permission_status.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:permission_handler/permission_handler.dart';

part 'add_property_images_state.dart';

class AddPropertyImagesCubit extends Cubit<AddPropertyImagesState> {
  final HsPermissionService _permissionService =
      HsSingleton.singleton.get<HsPermissionService>();

  AddPropertyImagesCubit() : super(AddPropertyImagesInitial());

  void onPhotoPermissionBottomSheetDismissed() {
    if (state is! OpenSettingScreen && state is! CancelPhotoAccess) {
      emit(ClosePhotoPermissionBottomSheet());
    }
  }

  void cancelPhotoAccess() {
    emit(CancelPhotoAccess());
  }

  void onSelectPhotoBottomSheetDismissed(List<String>? result) {
    emit(CloseSelectPhotoBottomSheet());
  }

  void openSelectPhotoBottomSheet() {
    emit(OpenSelectPhotoScreen());
  }

  void gotoSetting() {
    openAppSettings();
    emit(OpenSettingScreen());
  }

  void screenResumed() {
    if (state is OpenSettingScreen) {
      checkPhotoPermission();
    }
    // handle other states
  }

  void checkPhotoPermission() async {
    HsPermissionStatus status = await _permissionService.checkPhotoPermission();

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
