import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/models/permission/permission_service.dart';
import 'package:hatspace/models/permission/permission_status.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Map<String, dynamic> androidDeviceInfo(int version) => {
        'version': {
          'baseOS': 'baseOS',
          'codename': 'codename',
          'incremental': 'incremental',
          'previewSdkInt': version,
          'release': 'release',
          'sdkInt': version,
          'securityPatch': 'securityPatch',
        },
        'board': 'board',
        'bootloader': 'bootloader',
        'brand': 'brand',
        'device': 'device',
        'display': 'display',
        'fingerprint': 'fingerprint',
        'hardware': 'hardware',
        'host': 'host',
        'id': 'id',
        'manufacturer': 'manufacturer',
        'model': 'model',
        'product': 'product',
        'supported32BitAbis': [],
        'supported64BitAbis': [],
        'supportedAbis': [],
        'tags': 'tags',
        'type': 'type',
        'isPhysicalDevice': true,
        'systemFeatures': [],
        'displayMetrics': {
          'widthPx': 600.0,
          'heightPx': 600.0,
          'xDpi': 280.0,
          'yDpi': 280.0,
        },
        'serialNumber': 'serialNumber',
      };

  void setupDeviceInfo(int version) {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('dev.fluttercommunity.plus/device_info'),
            (MethodCall methodCall) async {
      expect(methodCall.method, 'getDeviceInfo');

      return androidDeviceInfo(version);
    });
  }

  void setupPermissionStatusAndExpectProperPermission(
      int permission, int status) {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('flutter.baseflow.com/permissions/methods'),
            (MethodCall methodCall) async {
      expect(methodCall.method, 'requestPermissions');

      // argument is 15 - storage
      expect(methodCall.arguments, [permission]);

      // return denied
      return {permission: status};
    });
  }

  void expectHsPermissionStatus(HsPermissionStatus expectedStatus) async {
    final HsPermissionService service = HsPermissionService();

    HsPermissionStatus permission = await service.checkPhotoPermission();

    expect(permission, expectedStatus);
  }

  group('Request Photo Permission Group', () {
    group('Android with SDK less than 32', () {
      test(
          'given SDK is 31 and permission is denied,'
          'when requestPhotoPermission,'
          'then request storage permission and hs permission status is denied',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        setupDeviceInfo(31);
        //storage = 15, denied = 0
        setupPermissionStatusAndExpectProperPermission(15, 0);
        expectHsPermissionStatus(HsPermissionStatus.denied);
        debugDefaultTargetPlatformOverride = null;
      });

      test(
          'given SDK is 31 and permission is granted,'
          'when requestPhotoPermission,'
          'then request storage permission and hs permission status is granted',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        setupDeviceInfo(31);
        //storage = 15, granted = 1
        setupPermissionStatusAndExpectProperPermission(15, 1);
        expectHsPermissionStatus(HsPermissionStatus.granted);
      });

      test(
          'given SDK is 31 and permission is restricted,'
          'when requestPhotoPermission,'
          'then request storage permission and hs permission status is denied',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        setupDeviceInfo(31);
        //storage = 15, restricted = 2
        setupPermissionStatusAndExpectProperPermission(15, 2);
        expectHsPermissionStatus(HsPermissionStatus.denied);
        debugDefaultTargetPlatformOverride = null;
      });

      test(
          'given SDK is 31 and permission is limited,'
          'when requestPhotoPermission,'
          'then request storage permission and hs permission status is limited',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        setupDeviceInfo(31);
        //storage = 15, limited = 3
        setupPermissionStatusAndExpectProperPermission(15, 3);
        expectHsPermissionStatus(HsPermissionStatus.limited);
        debugDefaultTargetPlatformOverride = null;
      });

      test(
          'given SDK is 31 and permission is permanentlyDenied,'
          'when requestPhotoPermission,'
          'then request storage permission and hs permission status is deniedForever',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        setupDeviceInfo(31);
        //storage = 15, permanentlyDenied = 4
        setupPermissionStatusAndExpectProperPermission(15, 4);
        expectHsPermissionStatus(HsPermissionStatus.deniedForever);
        debugDefaultTargetPlatformOverride = null;
      });

      test(
          'given SDK is 31 and permission is provisional,'
          'when requestPhotoPermission,'
          'then request storage permission and hs permission status is granted',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        setupDeviceInfo(31);
        //storage = 15, provisional = 5
        setupPermissionStatusAndExpectProperPermission(15, 5);
        expectHsPermissionStatus(HsPermissionStatus.granted);
        debugDefaultTargetPlatformOverride = null;
      });
    });

    group('Android with SDK more than 32', () {
      test(
          'given SDK is 33 and permission is denied,'
          'when requestPhotoPermission,'
          'then request photo permission and hs permission status is denied',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        setupDeviceInfo(33);
        //photo = 9, denied = 0
        setupPermissionStatusAndExpectProperPermission(9, 0);
        expectHsPermissionStatus(HsPermissionStatus.denied);
        debugDefaultTargetPlatformOverride = null;
      });

      test(
          'given SDK is 33 and permission is granted,'
          'when requestPhotoPermission,'
          'then request photo permission and hs permission status is granted',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        setupDeviceInfo(33);
        //photo = 9, granted = 1
        setupPermissionStatusAndExpectProperPermission(9, 1);
        expectHsPermissionStatus(HsPermissionStatus.granted);
        debugDefaultTargetPlatformOverride = null;
      });

      test(
          'given SDK is 33 and permission is restricted,'
          'when requestPhotoPermission,'
          'then request photo permission and hs permission status is denied',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        setupDeviceInfo(33);
        //photo = 9, restricted = 2
        setupPermissionStatusAndExpectProperPermission(9, 2);
        expectHsPermissionStatus(HsPermissionStatus.denied);
        debugDefaultTargetPlatformOverride = null;
      });

      test(
          'given SDK is 33 and permission is limited,'
          'when requestPhotoPermission,'
          'then request photo permission and hs permission status is limited',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        setupDeviceInfo(33);
        //photo = 9, limited = 3
        setupPermissionStatusAndExpectProperPermission(9, 3);
        expectHsPermissionStatus(HsPermissionStatus.limited);
        debugDefaultTargetPlatformOverride = null;
      });

      test(
          'given SDK is 33 and permission is permanentlyDenied,'
          'when requestPhotoPermission,'
          'then request photo permission and hs permission status is deniedForever',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        setupDeviceInfo(33);
        //photo = 9, permanentlyDenied = 4
        setupPermissionStatusAndExpectProperPermission(9, 4);
        expectHsPermissionStatus(HsPermissionStatus.deniedForever);
        debugDefaultTargetPlatformOverride = null;
      });

      test(
          'given SDK is 33 and permission is provisional,'
          'when requestPhotoPermission,'
          'then request photo permission and hs permission status is granted',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
        setupDeviceInfo(33);
        //photo = 9, provisional = 5
        setupPermissionStatusAndExpectProperPermission(9, 5);
        expectHsPermissionStatus(HsPermissionStatus.granted);
        debugDefaultTargetPlatformOverride = null;
      });
    });

    group('iOS', () {
      test(
          'given permission is denied,'
          'when requestPhotoPermission,'
          'then request photo permission and hs permission status is denied',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
                const MethodChannel('dev.fluttercommunity.plus/device_info'),
                (MethodCall methodCall) async {
          throw Exception('This method must not be called');
        });
        //photo = 9, denied = 0
        setupPermissionStatusAndExpectProperPermission(9, 0);
        expectHsPermissionStatus(HsPermissionStatus.denied);
        debugDefaultTargetPlatformOverride = null;
      });

      test(
          'given permission is granted,'
          'when requestPhotoPermission,'
          'then request photo permission and hs permission status is granted',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
                const MethodChannel('dev.fluttercommunity.plus/device_info'),
                (MethodCall methodCall) async {
          throw Exception('This method must not be called');
        });
        //photo = 9, granted = 1
        setupPermissionStatusAndExpectProperPermission(9, 1);
        expectHsPermissionStatus(HsPermissionStatus.granted);
        debugDefaultTargetPlatformOverride = null;
      });

      test(
          'given permission is restricted,'
          'when requestPhotoPermission,'
          'then request photo permission and hs permission status is denied',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
                const MethodChannel('dev.fluttercommunity.plus/device_info'),
                (MethodCall methodCall) async {
          throw Exception('This method must not be called');
        });
        //photo = 9, restricted = 2
        setupPermissionStatusAndExpectProperPermission(9, 2);
        expectHsPermissionStatus(HsPermissionStatus.denied);
        debugDefaultTargetPlatformOverride = null;
      });

      test(
          'given permission is limited,'
          'when requestPhotoPermission,'
          'then request photo permission and hs permission status is limited',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
                const MethodChannel('dev.fluttercommunity.plus/device_info'),
                (MethodCall methodCall) async {
          throw Exception('This method must not be called');
        });
        //photo = 9, limited = 3
        setupPermissionStatusAndExpectProperPermission(9, 3);
        expectHsPermissionStatus(HsPermissionStatus.limited);
        debugDefaultTargetPlatformOverride = null;
      });

      test(
          'given permission is permanentlyDenied,'
          'when requestPhotoPermission,'
          'then request photo permission and hs permission status is deniedForever',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
                const MethodChannel('dev.fluttercommunity.plus/device_info'),
                (MethodCall methodCall) async {
          throw Exception('This method must not be called');
        });
        //photo = 9, permanentlyDenied = 4
        setupPermissionStatusAndExpectProperPermission(9, 4);
        expectHsPermissionStatus(HsPermissionStatus.deniedForever);
        debugDefaultTargetPlatformOverride = null;
      });

      test(
          'given permission is provisional,'
          'when requestPhotoPermission,'
          'then request photo permission and hs permission status is granted',
          () async {
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
                const MethodChannel('dev.fluttercommunity.plus/device_info'),
                (MethodCall methodCall) async {
          throw Exception('This method must not be called');
        });
        //photo = 9, provisional = 5
        setupPermissionStatusAndExpectProperPermission(9, 5);
        expectHsPermissionStatus(HsPermissionStatus.granted);
        debugDefaultTargetPlatformOverride = null;
      });
    });
  });
}
