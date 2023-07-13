import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:hatspace/features/select_photo/view_model/select_photo_cubit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('com.fluttercandies/photo_manager'),
      (message) async {
        if (message.method == 'getAssetCount') {
          return 5;
        }

        if (message.method == 'getAssetsByRange') {
          return {'data': []};
        }

        return null;
      },
    );
  });

  blocTest('verify PhotoCountLoaded is emitted when load photos',
      build: () => SelectPhotoCubit(),
      act: (bloc) => bloc.loadPhotos(),
      expect: () => [isA<PhotosLoaded>()]);
}
