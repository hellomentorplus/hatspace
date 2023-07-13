import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/add_property/view/widgets/add_property_images_view.dart';
import 'package:hatspace/features/add_property/view_model/add_property_images/add_property_images_cubit.dart';
import 'package:hatspace/features/select_photo/view/select_photo_bottom_sheet.dart';
import 'package:hatspace/models/permission/permission_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_warning_bottom_sheet.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../widget_tester_extension.dart';
import 'add_property_images_view_test.mocks.dart';

@GenerateMocks([AddPropertyImagesCubit, HsPermissionService])
void main() {
  final MockAddPropertyImagesCubit addPropertyImagesCubit =
      MockAddPropertyImagesCubit();
  final MockHsPermissionService permissionService = MockHsPermissionService();

  setUpAll(() {
    when(addPropertyImagesCubit.state)
        .thenAnswer((_) => AddPropertyImagesInitial());
    when(addPropertyImagesCubit.stream)
        .thenAnswer((_) => Stream.value(AddPropertyImagesInitial()));
    HsSingleton.singleton
        .registerSingleton<HsPermissionService>(permissionService);
  });

  tearDown(() {
    reset(addPropertyImagesCubit);
    reset(permissionService);
  });

  group('verify UI Add image screen by state', () {
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
        'then show select photo bottom sheet', (widgetTester) async {
      const Widget widget = AddPropertyImagesBody();

      when(addPropertyImagesCubit.state)
          .thenAnswer((_) => PhotoPermissionGranted());
      when(addPropertyImagesCubit.stream)
          .thenAnswer((_) => Stream.value(PhotoPermissionGranted()));

      await mockNetworkImagesFor(() =>
          widgetTester.blocWrapAndPump<AddPropertyImagesCubit>(
              addPropertyImagesCubit, widget,
              infiniteAnimationWidget: true));
      await widgetTester.pumpAndSettle();
      expect(find.byType(AddPropertyImagesBody), findsOneWidget);

      expect(
          find.ancestor(
              of: find.text('"HATSpace" Would Like to Photo Access'),
              matching: find.byType(HsWarningBottomSheetView)),
          findsNothing);
      expect(find.byType(SelectPhotoBottomSheet), findsOneWidget);
      expect(find.text('All Photos'), findsOneWidget);
    });

    testWidgets(
        'given state is PhotoPermissionDenied '
        'when launching AddPropertyImagesView '
        'then no bottom sheet is shown', (widgetTester) async {
      const Widget widget = AddPropertyImagesView();

      when(addPropertyImagesCubit.state)
          .thenAnswer((_) => PhotoPermissionDenied());
      when(addPropertyImagesCubit.stream)
          .thenAnswer((_) => Stream.value(PhotoPermissionDenied()));

      await widgetTester.blocWrapAndPump<AddPropertyImagesCubit>(
          addPropertyImagesCubit, widget);
      await expectLater(find.byType(AddPropertyImagesBody), findsOneWidget);

      expect(find.text('Select Photo'), findsNothing);
      expect(
          find.ancestor(
              of: find.text('"HATSpace" Would Like to Photo Access'),
              matching: find.byType(HsWarningBottomSheetView)),
          findsNothing);
    });

    testWidgets(
        'given state is PhotoPermissionDeniedForever '
        'when launching AddPropertyImagesView '
        'then show photo access bottom sheet', (widgetTester) async {
      const Widget widget = AddPropertyImagesBody();

      when(addPropertyImagesCubit.state)
          .thenAnswer((_) => PhotoPermissionDeniedForever());
      when(addPropertyImagesCubit.stream)
          .thenAnswer((_) => Stream.value(PhotoPermissionDeniedForever()));

      await widgetTester.blocWrapAndPump<AddPropertyImagesCubit>(
        addPropertyImagesCubit,
        widget,
      );
      await expectLater(find.byType(AddPropertyImagesBody), findsOneWidget);
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
      expect(find.text('Select Photo'), findsNothing);
      SvgPicture uploadPhoto = widgetTester.widget(find.descendant(
          of: find.byType(HsWarningBottomSheetView),
          matching: find.byType(SvgPicture)));
      BytesLoader bytesLoader = uploadPhoto.bytesLoader;
      expect(bytesLoader, isA<SvgAssetLoader>());
      expect((bytesLoader as SvgAssetLoader).assetName,
          'assets/icons/photo_access.svg');
      expect(
          find.text('"HATSpace" Would Like to Photo Access'), findsOneWidget);
      expect(
          find.text(
              'Please go to Settings and allow photos access for HATSpace.'),
          findsOneWidget);
      expect(
          find.ancestor(
              of: find.text('Go to Setting'),
              matching: find.byType(PrimaryButton)),
          findsOneWidget);
      expect(
          find.ancestor(
              of: find.text('Cancel'), matching: find.byType(SecondaryButton)),
          findsOneWidget);
    });
  });

  group('verify interaction', () {
    testWidgets(
        'given add_image screen is empty photo '
        'when tap on upload photo '
        'then permission service should request photo permission',
        (widgetTester) async {
      const Widget widget = AddPropertyImagesBody();

      when(addPropertyImagesCubit.state)
          .thenAnswer((_) => AddPropertyImagesInitial());
      when(addPropertyImagesCubit.stream)
          .thenAnswer((_) => Stream.value(AddPropertyImagesInitial()));

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

    testWidgets(
        'given photo access bottom sheet is displayed '
        'when tap on go to setting '
        'then navigate to application setting screen', (widgetTester) async {
      const Widget widget = AddPropertyImagesBody();

      when(addPropertyImagesCubit.state)
          .thenAnswer((_) => PhotoPermissionDeniedForever());
      when(addPropertyImagesCubit.stream)
          .thenAnswer((_) => Stream.value(PhotoPermissionDeniedForever()));

      await widgetTester.blocWrapAndPump<AddPropertyImagesCubit>(
        addPropertyImagesCubit,
        widget,
      );
      await expectLater(find.byType(AddPropertyImagesBody), findsOneWidget);
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);

      Finder goToSettingBtn = find.ancestor(
          of: find.text('Go to Setting'), matching: find.byType(PrimaryButton));

      await widgetTester.ensureVisible(goToSettingBtn);
      await widgetTester.tap(goToSettingBtn);
      await widgetTester.pumpAndSettle();

      verify(addPropertyImagesCubit.gotoSetting()).called(1);
      expect(find.byType(HsWarningBottomSheetView), findsNothing);
    });

    testWidgets(
        'given photo access bottom sheet is displayed '
        'when tap on cancel '
        'then bottom sheet is closed', (widgetTester) async {
      const Widget widget = AddPropertyImagesBody();

      when(addPropertyImagesCubit.state)
          .thenAnswer((_) => PhotoPermissionDeniedForever());
      when(addPropertyImagesCubit.stream)
          .thenAnswer((_) => Stream.value(PhotoPermissionDeniedForever()));

      await widgetTester.blocWrapAndPump<AddPropertyImagesCubit>(
        addPropertyImagesCubit,
        widget,
      );
      await expectLater(find.byType(AddPropertyImagesBody), findsOneWidget);
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);

      Finder cancelBtn = find.ancestor(
          of: find.text('Cancel'), matching: find.byType(SecondaryButton));

      await widgetTester.ensureVisible(cancelBtn);
      await widgetTester.tap(cancelBtn);
      await widgetTester.pumpAndSettle();

      verify(addPropertyImagesCubit.cancelPhotoAccess()).called(1);
      expect(find.byType(AddPropertyImagesBody), findsOneWidget);
      expect(find.byType(HsWarningBottomSheetView), findsNothing);
    });
  });

  testWidgets(
      'given state is PhotoPermissionGranted '
      'when tap on Upload photo '
      'then verify SelectPhotoBottomSheet is visible',
      (WidgetTester widgetTester) async {
    when(addPropertyImagesCubit.state)
        .thenAnswer((realInvocation) => PhotoPermissionGranted());
    when(addPropertyImagesCubit.stream)
        .thenAnswer((realInvocation) => Stream.value(PhotoPermissionGranted()));

    const Widget widget = AddPropertyImagesBody();

    await mockNetworkImagesFor(
        () => widgetTester.blocWrapAndPump<AddPropertyImagesCubit>(
              addPropertyImagesCubit,
              widget,
            ));
    await widgetTester.pumpAndSettle();

    expect(find.byType(SelectPhotoBottomSheet), findsOneWidget);
  });
}
