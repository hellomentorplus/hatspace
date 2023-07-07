import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_images_view.dart';
import 'package:hatspace/features/add_property/view_model/add_property_images/add_property_images_cubit.dart';
import 'package:hatspace/models/permission/permission_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../widget_tester_extension.dart';
import 'add_property_images_view_test.mocks.dart';

@GenerateMocks([AddPropertyImagesCubit, HsPermissionService])
void main() {
  final MockAddPropertyImagesCubit addPropertyImagesCubit =
      MockAddPropertyImagesCubit();
  final MockHsPermissionService permissionService = MockHsPermissionService();

  setUpAll(() {
    when(addPropertyImagesCubit.state)
        .thenAnswer((realInvocation) => AddPropertyImagesInitial());
    when(addPropertyImagesCubit.stream).thenAnswer(
        (realInvocation) => Stream.value(AddPropertyImagesInitial()));
    HsSingleton.singleton
        .registerSingleton<HsPermissionService>(permissionService);
  });

  tearDown(() {
    reset(addPropertyImagesCubit);
    reset(permissionService);
  });

  group('verify UI', () {
    testWidgets(
        'given state is AddPropertyImagesInitial '
        'when launching AddPropertyImagesView '
        'then verify AddPropertyImagesView with empty selected images',
        (widgetTester) async {
      const Widget widget = AddPropertyImagesView();

      await widgetTester.blocWrapAndPump<AddPropertyImagesCubit>(
          addPropertyImagesCubit, widget);

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
        'given state is PhotoPermissionGranted '
        'when launching AddPropertyImagesView '
        'then verify AddPropertyImagesView with empty selected images',
        (widgetTester) async {
      const Widget widget = AddPropertyImagesView();

      when(addPropertyImagesCubit.state)
          .thenAnswer((realInvocation) => PhotoPermissionGranted());
      when(addPropertyImagesCubit.stream).thenAnswer(
          (realInvocation) => Stream.value(PhotoPermissionGranted()));

      await widgetTester.blocWrapAndPump<AddPropertyImagesCubit>(
          addPropertyImagesCubit, widget);

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
        'given state is PhotoPermissionDenied '
        'when launching AddPropertyImagesView '
        'then verify AddPropertyImagesView with empty selected images',
        (widgetTester) async {
      const Widget widget = AddPropertyImagesView();

      when(addPropertyImagesCubit.state)
          .thenAnswer((realInvocation) => PhotoPermissionDenied());
      when(addPropertyImagesCubit.stream).thenAnswer(
          (realInvocation) => Stream.value(PhotoPermissionDenied()));

      await widgetTester.blocWrapAndPump<AddPropertyImagesCubit>(
          addPropertyImagesCubit, widget);

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
        'given state is PhotoPermissionDeniedForever '
        'when launching AddPropertyImagesView '
        'then verify AddPropertyImagesView with empty selected images',
        (widgetTester) async {
      const Widget widget = AddPropertyImagesView();

      when(addPropertyImagesCubit.state)
          .thenAnswer((realInvocation) => PhotoPermissionDeniedForever());
      when(addPropertyImagesCubit.stream).thenAnswer(
          (realInvocation) => Stream.value(PhotoPermissionDeniedForever()));

      await widgetTester.blocWrapAndPump<AddPropertyImagesCubit>(
          addPropertyImagesCubit, widget);

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
  });

  group('verify interaction', () {
    testWidgets(
        'given photo permission is denied '
        'when taps on upload photo '
        'then permission service should request photo permission',
        (widgetTester) async {
      const Widget widget = AddPropertyImagesBody();

      when(addPropertyImagesCubit.state)
          .thenAnswer((realInvocation) => PhotoPermissionDenied());
      when(addPropertyImagesCubit.stream).thenAnswer(
          (realInvocation) => Stream.value(PhotoPermissionDenied()));

      await widgetTester.blocWrapAndPump<AddPropertyImagesCubit>(
        addPropertyImagesCubit,
        widget,
      );
      await expectLater(find.byType(AddPropertyImagesBody), findsOneWidget);

      Finder svgPicture = find.descendant(
        of: find.byType(InkWell),
        matching: find.byType(SvgPicture),
      );

      SvgPicture uploadPhoto = widgetTester.widget(svgPicture);
      BytesLoader bytesLoader = uploadPhoto.bytesLoader;
      expect(bytesLoader, isA<SvgAssetLoader>());
      expect((bytesLoader as SvgAssetLoader).assetName,
          'assets/images/upload_photo.svg');

      await widgetTester.ensureVisible(svgPicture);
      await widgetTester.tap(svgPicture);
      await widgetTester.pumpAndSettle();

      verify(addPropertyImagesCubit.checkPhotoPermission()).called(1);
    });
  });
}
