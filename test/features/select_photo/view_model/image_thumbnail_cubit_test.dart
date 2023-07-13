import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/select_photo/view_model/image_thumbnail_cubit.dart';
import 'package:hatspace/models/photo/photo_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_manager/photo_manager.dart';

import 'image_thumbnail_cubit_test.mocks.dart';

@GenerateMocks([PhotoService, File])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MockPhotoService photoService = MockPhotoService();
  final MockFile file = MockFile();

  setUpAll(() {
    HsSingleton.singleton.registerSingleton<PhotoService>(photoService);

    when(photoService.createThumbnail(any))
        .thenAnswer((realInvocation) => Future.value(file));
  });

  blocTest(
    'given entity origin file is null,'
    ' when createThumbnail,'
    ' then return ThumbnailError',
    build: () => ImageThumbnailCubit(),
    setUp: () {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('com.fluttercandies/photo_manager'),
        (message) async {
          if (message.method == 'getFullFile') {
            return null;
          }

          return null;
        },
      );
    },
    act: (bloc) => bloc.createThumbnail(AssetEntity(
        id: 'id', typeInt: AssetType.image.index, width: 10, height: 10)),
    expect: () => [isA<ThumbnailError>()],
  );

  blocTest(
    'given entity origin file is not null,'
    ' when createThumbnail,'
    ' then return ThumbnailLoaded,'
    ' and call photoService createThumbnail',
    build: () => ImageThumbnailCubit(),
    setUp: () {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('com.fluttercandies/photo_manager'),
        (message) async {
          if (message.method == 'getFullFile') {
            return 'path';
          }

          return null;
        },
      );
    },
    act: (bloc) => bloc.createThumbnail(AssetEntity(
        id: 'id', typeInt: AssetType.image.index, width: 10, height: 10)),
    expect: () => [isA<ThumbnailLoaded>()],
    verify: (bloc) {
      verify(photoService.createThumbnail(any)).called(1);
    },
  );
}
