import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/features/select_photo/view/widgets/item_square_view.dart';
import 'package:hatspace/features/select_photo/view_model/image_thumbnail_cubit.dart';
import 'package:hatspace/features/select_photo/view_model/photo_selection_cubit.dart';
import 'package:hatspace/features/select_photo/view_model/select_photo_cubit.dart';
import 'package:hatspace/models/photo/photo_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../find_extension.dart';
import '../../widget_tester_extension.dart';
import 'item_square_view_test.mocks.dart';

@GenerateMocks([
  PhotoService,
  SelectPhotoCubit,
  ImageThumbnailCubit,
  File,
  PhotoSelectionCubit
])
void main() {
  final MockPhotoService photoService = MockPhotoService();
  final MockSelectPhotoCubit selectPhotoCubit = MockSelectPhotoCubit();
  final MockImageThumbnailCubit imageThumbnailCubit = MockImageThumbnailCubit();
  final MockPhotoSelectionCubit photoSelectionCubit = MockPhotoSelectionCubit();
  final MockFile file = MockFile();

  setUpAll(() {
    HsSingleton.singleton.registerSingleton<PhotoService>(photoService);

    when(selectPhotoCubit.state)
        .thenAnswer((realInvocation) => SelectPhotoInitial());
    when(selectPhotoCubit.stream)
        .thenAnswer((realInvocation) => const Stream.empty());

    when(file.path).thenAnswer((realInvocation) => 'path');
    when(file.length()).thenAnswer((realInvocation) => Future.value(10));
    when(file.readAsBytes())
        .thenAnswer((realInvocation) => generateImageBytes());
    when(photoSelectionCubit.state)
        .thenAnswer((realInvocation) => PhotoSelectionInitial());
    when(photoSelectionCubit.stream)
        .thenAnswer((realInvocation) => const Stream.empty());
  });

  testWidgets('verify bloc used in this widget', (widgetTester) async {
    when(selectPhotoCubit.state).thenReturn(PhotosLoaded([
      AssetEntity(
          id: 'id', typeInt: AssetType.image.index, width: 10, height: 10)
    ]));

    const Widget widget = ImageSquareView(index: 0);

    await widgetTester.blocWrapAndPump<SelectPhotoCubit>(
        selectPhotoCubit, widget,
        infiniteAnimationWidget: true);

    expect(find.byType(BlocProvider<ImageThumbnailCubit>), findsOneWidget);
    expect(find.byType(BlocBuilder<ImageThumbnailCubit, ImageThumbnailState>),
        findsOneWidget);
  });

  group('verify different UI base on ImageThumbnailState', () {
    // TODO update test when handle error scenario
    testWidgets(
        'given state is ThumbnailError, '
        'when load ImageSquareBody, '
        'then show SizedBox', (widgetTester) async {
      when(imageThumbnailCubit.state)
          .thenAnswer((realInvocation) => ThumbnailError());
      when(imageThumbnailCubit.stream)
          .thenAnswer((realInvocation) => const Stream.empty());

      const Widget widget = ImageSquareBody();

      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<ImageThumbnailCubit>(
          create: (context) => imageThumbnailCubit,
        ),
        BlocProvider<PhotoSelectionCubit>(
          create: (context) => photoSelectionCubit,
        )
      ], widget, infiniteAnimationWidget: true);

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets(
        'given state is ThumbnailLoaded, '
        'when load ImageSquareBody, '
        'then show Image', (widgetTester) async {
      when(imageThumbnailCubit.state).thenAnswer((realInvocation) =>
          ThumbnailLoaded(thumbnail: file, width: 10, height: 10));
      when(imageThumbnailCubit.stream)
          .thenAnswer((realInvocation) => const Stream.empty());

      const Widget widget = ImageSquareBody();

      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<ImageThumbnailCubit>(
          create: (context) => imageThumbnailCubit,
        ),
        BlocProvider<PhotoSelectionCubit>(
          create: (context) => photoSelectionCubit,
        )
      ], widget, infiniteAnimationWidget: true);

      expect(find.containerWithImageFile('path'), findsOneWidget);
    });
  });
}

Future<Uint8List> generateImageBytes() async {
  // create canvas to draw
  final PictureRecorder recorder = PictureRecorder();
  Canvas(
      recorder, Rect.fromPoints(const Offset(0.0, 0.0), const Offset(10, 10)));
  final ByteData? pngBytes =
      await (await recorder.endRecording().toImage(10, 10))
          .toByteData(format: ImageByteFormat.png);
  return Uint8List.view(pngBytes!.buffer);
}
