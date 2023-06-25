import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:hatspace/models/permission/permission_status.dart';

class HsPermissionService {
  Future<HsPermissionStatus> checkPhotoPermission() async {
    PermissionStatus status;
    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      if (androidInfo.version.sdkInt <= 32) {
        status = await Permission.storage.status;
      } else {
        status = await Permission.photos.status;
      }
    } else {
      status = await Permission.photos.status;
    }

    return _toHsPermissionStatus(status);
  }

  Future<HsPermissionStatus> requestPhotoPermission() async {
    PermissionStatus status;
    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      if (androidInfo.version.sdkInt <= 32) {
        status = await Permission.storage.request();
      } else {
        status = await Permission.photos.request();
      }
    } else {
      status = await Permission.photos.request();
    }

    return _toHsPermissionStatus(status);
  }

  HsPermissionStatus _toHsPermissionStatus(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return HsPermissionStatus.granted;
      case PermissionStatus.limited:
        return HsPermissionStatus.limited;
      case PermissionStatus.restricted:
        return HsPermissionStatus.denied;
      case PermissionStatus.provisional:
        return HsPermissionStatus.granted;
      case PermissionStatus.denied:
        return HsPermissionStatus.denied;
      case PermissionStatus.permanentlyDenied:
        return HsPermissionStatus.deniedForever;
    }
  }
}
