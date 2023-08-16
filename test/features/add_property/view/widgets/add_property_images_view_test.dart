import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_images_view.dart';
import 'package:hatspace/features/add_property/view_model/add_property_cubit.dart';
import 'package:hatspace/features/add_property/view_model/add_property_images/add_property_image_selected_cubit.dart';
import 'package:hatspace/features/select_photo/view/select_photo_bottom_sheet.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/models/photo/photo_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../find_extension.dart';
import '../../../../widget_tester_extension.dart';
import 'add_property_images_view_test.mocks.dart';

@GenerateMocks([PhotoService, AddPropertyImageSelectedCubit, AddPropertyCubit])
void main() {
  final MockPhotoService photoService = MockPhotoService();
  final MockAddPropertyImageSelectedCubit addPropertyImageSelectedCubit =
      MockAddPropertyImageSelectedCubit();
  final MockAddPropertyCubit addPropertyCubit = MockAddPropertyCubit();

  setUpAll(() {
    HsSingleton.singleton.registerSingleton<PhotoService>(photoService);
  });

  setUp(() {
    when(addPropertyImageSelectedCubit.state)
        .thenReturn(AddPropertyImageSelectedInitial());
    when(addPropertyImageSelectedCubit.stream)
        .thenAnswer((realInvocation) => const Stream.empty());

    when(addPropertyCubit.state).thenReturn(const AddPropertyInitial());
    when(addPropertyCubit.stream)
        .thenAnswer((realInvocation) => const Stream.empty());

    when(addPropertyCubit.photos).thenAnswer((realInvocation) => []);
  });

  tearDown(() {
    reset(addPropertyCubit);
    reset(addPropertyImageSelectedCubit);
    reset(photoService);
  });

  group('verify UI Add image screen by state', () {
    testWidgets(
        'given state is AddPropertyImagesInitial '
        'when launching AddPropertyImagesView '
        'then verify AddPropertyImagesView with empty selected images',
        (widgetTester) async {
      const Widget widget = AddPropertyImagesView();

      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<AddPropertyCubit>(
          create: (context) => addPropertyCubit,
        ),
        BlocProvider<AddPropertyImageSelectedCubit>(
          create: (context) => addPropertyImageSelectedCubit,
        )
      ], widget);

      expect(find.byType(Text), findsNWidgets(2));
      expect(find.text('Let\'s add some photos of your place'), findsOneWidget);
      expect(find.text('Require at least 4 photos *'), findsOneWidget);
      SvgPicture uploadPhoto = widgetTester.widget(find.descendant(
          of: find.byType(AddPropertyImagesView),
          matching: find.byType(SvgPicture)));
      BytesLoader bytesLoader = uploadPhoto.bytesLoader;
      expect(bytesLoader, isA<SvgAssetLoader>());
      expect((bytesLoader as SvgAssetLoader).assetName,
          'assets/images/upload_photo.svg');
    });

    testWidgets(
        'given state is PhotoSelectionReturned '
        'when launching '
        'then show photos with cover photo', (widgetTester) async {
      const Widget widget = AddPropertyImagesBody();

      when(addPropertyImageSelectedCubit.state).thenAnswer((_) =>
          const PhotoSelectionReturned(paths: ['photo'], allowAddImage: true));
      when(addPropertyImageSelectedCubit.stream).thenAnswer((_) => Stream.value(
          const PhotoSelectionReturned(paths: ['photo'], allowAddImage: true)));

      await widgetTester.multiBlocWrapAndPump(
        [
          BlocProvider<AddPropertyCubit>(
            create: (context) => addPropertyCubit,
          ),
          BlocProvider<AddPropertyImageSelectedCubit>(
            create: (context) => addPropertyImageSelectedCubit,
          )
        ],
        widget,
      );
      expect(find.byType(GridView), findsOneWidget);
      expect(find.text('Cover photo'), findsOneWidget);
    });
  });

  group('Test with selected image', () {
    testWidgets(
        'given allow add image is true,'
        'when load UI,'
        'then show Add Image view', (widgetTester) async {
      when(addPropertyImageSelectedCubit.state).thenReturn(
          PhotoSelectionReturned(
              paths: List.filled(9, 'path'), allowAddImage: true));

      const Widget widget = AddPropertyImagesBody();

      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump([
            BlocProvider<AddPropertyCubit>(
              create: (context) => addPropertyCubit,
            ),
            BlocProvider<AddPropertyImageSelectedCubit>(
              create: (context) => addPropertyImageSelectedCubit,
            )
          ], widget));

      expect(find.svgPictureWithAssets(Assets.images.upload), findsOneWidget);
      expect(find.byType(ImagePreviewView), findsNWidgets(9));
    });

    testWidgets(
        'given allow add image is false,'
        'when load UI,'
        'then do not show Add Image view', (widgetTester) async {
      when(addPropertyImageSelectedCubit.state).thenReturn(
          PhotoSelectionReturned(
              paths: List.filled(10, 'path'), allowAddImage: false));
      when(addPropertyImageSelectedCubit.stream)
          .thenAnswer((realInvocation) => const Stream.empty());

      const Widget widget = AddPropertyImagesBody();

      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump([
            BlocProvider<AddPropertyCubit>(
              create: (context) => addPropertyCubit,
            ),
            BlocProvider<AddPropertyImageSelectedCubit>(
              create: (context) => addPropertyImageSelectedCubit,
            )
          ], widget));

      expect(find.svgPictureWithAssets(Assets.images.upload), findsNothing);
      expect(find.byType(ImagePreviewView), findsNWidgets(10));
    });

    testWidgets(
        'given load more photo is visible,'
            'when tap on load more photo,'
            'then show showSelectPhotoBottomSheet', (widgetTester) async {
      when(addPropertyImageSelectedCubit.state).thenReturn(
          PhotoSelectionReturned(
              paths: List.filled(5, 'path'), allowAddImage: true));
      when(addPropertyImageSelectedCubit.stream)
          .thenAnswer((realInvocation) => const Stream.empty());

      const Widget widget = AddPropertyImagesBody();

      await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump([
        BlocProvider<AddPropertyCubit>(
          create: (context) => addPropertyCubit,
        ),
        BlocProvider<AddPropertyImageSelectedCubit>(
          create: (context) => addPropertyImageSelectedCubit,
        )
      ], widget));

      widgetTester.ensureVisible(find.svgPictureWithAssets(Assets.images.upload));
      await widgetTester.tap(find.svgPictureWithAssets(Assets.images.upload));
      await widgetTester.pumpAndSettle();

      expect(find.byType(SelectPhotoBottomSheet), findsOneWidget);
    });

  });
}
