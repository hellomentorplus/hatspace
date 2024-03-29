import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/features/select_photo/view/select_photo_bottom_sheet.dart';
import 'package:hatspace/features/select_photo/view_model/lost_data_bottom_sheet_cubit.dart';
import 'package:hatspace/features/select_photo/view_model/photo_selection_cubit.dart';
import 'package:hatspace/features/select_photo/view_model/select_photo_cubit.dart';
import 'package:hatspace/models/photo/photo_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_warning_bottom_sheet.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../widget_tester_extension.dart';
import 'select_photo_bottom_sheet_test.mocks.dart';

@GenerateMocks([
  SelectPhotoCubit,
  PhotoSelectionCubit,
  LostDataBottomSheetCubit,
  PhotoService
])
@GenerateNiceMocks([MockSpec<AssetEntity>()])
void main() async {
  await HatSpaceStrings.load(const Locale('en'));

  final MockSelectPhotoCubit selectPhotoCubit = MockSelectPhotoCubit();
  final MockPhotoSelectionCubit photoSelectionCubit = MockPhotoSelectionCubit();
  final MockLostDataBottomSheetCubit lostDataBottomSheetCubit =
      MockLostDataBottomSheetCubit();
  final MockPhotoService photoService = MockPhotoService();

  setUpAll(() {
    HsSingleton.singleton.registerSingleton<PhotoService>(photoService);
  });

  setUp(() {
    when(selectPhotoCubit.state).thenReturn(SelectPhotoInitial());
    when(selectPhotoCubit.stream)
        .thenAnswer((realInvocation) => const Stream.empty());

    when(photoSelectionCubit.state).thenReturn(PhotoSelectionInitial());
    when(photoSelectionCubit.stream)
        .thenAnswer((realInvocation) => const Stream.empty());

    when(lostDataBottomSheetCubit.state)
        .thenReturn(LostDataBottomSheetInitial());
    when(lostDataBottomSheetCubit.stream)
        .thenAnswer((realInvocation) => const Stream.empty());
  });

  test('verify photo tab label', () {
    expect(PhotoTabs.allPhotos.labelDisplay, 'All Photos');
    // TODO verify more tabs
  });

  test('verify photo tab view', () {
    expect(PhotoTabs.allPhotos.tabView, isA<AllPhotosView>());
    // TODO verify more tabs
  });

  testWidgets('verify common layout on select photo', (widgetTester) async {
    const Widget widget = SelectPhotoBottomSheet();

    await widgetTester.wrapAndPump(widget);

    expect(find.text('All Photos'), findsOneWidget);
  });

  testWidgets(
      'given state is PhotosLoaded,'
      'when load AllPhotosView,'
      'then GridView is visible', (widgetTester) async {
    when(selectPhotoCubit.state)
        .thenAnswer((realInvocation) => const PhotosLoaded([]));

    const Widget widget = AllPhotosView();

    await widgetTester.multiBlocWrapAndPump([
      BlocProvider<SelectPhotoCubit>(
        create: (context) => selectPhotoCubit,
      ),
      BlocProvider<PhotoSelectionCubit>(
        create: (context) => photoSelectionCubit,
      )
    ], widget);

    expect(find.byType(GridView), findsOneWidget);

    final GridView gridView = widgetTester.widget(find.byType(GridView));

    expect(gridView.gridDelegate,
        isA<SliverGridDelegateWithFixedCrossAxisCount>());

    // 4 columns grid
    final SliverGridDelegateWithFixedCrossAxisCount delegate =
        gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
    expect(delegate.crossAxisCount, 4);
  });

  testWidgets(
      'given state is not PhotosLoaded,'
      'when load AllPhotosView,'
      'then GridView is not visible', (widgetTester) async {
    when(selectPhotoCubit.state)
        .thenAnswer((realInvocation) => SelectPhotoInitial());

    const Widget widget = AllPhotosView();

    await widgetTester.multiBlocWrapAndPump([
      BlocProvider<SelectPhotoCubit>(
        create: (context) => selectPhotoCubit,
      ),
      BlocProvider<PhotoSelectionCubit>(
        create: (context) => photoSelectionCubit,
      )
    ], widget);
    await widgetTester.pumpAndSettle();

    expect(find.byType(GridView), findsNothing);
  });

  testWidgets(
      'given SelectPhoto bottom sheet is visible and user does not select any photo,'
      'when user presses X button,'
      'then SelectPhoto bottom sheet is dismissed', (widgetTester) async {
    when(selectPhotoCubit.state).thenReturn(const PhotosLoaded([]));

    when(photoSelectionCubit.selectedItemCount).thenReturn(0);

    const Widget widget = SelectPhotoBody();

    await widgetTester.multiBlocWrapAndPump([
      BlocProvider<SelectPhotoCubit>(
        create: (context) => selectPhotoCubit,
      ),
      BlocProvider<PhotoSelectionCubit>(
        create: (context) => photoSelectionCubit,
      ),
      BlocProvider<LostDataBottomSheetCubit>(
        create: (context) => lostDataBottomSheetCubit,
      ),
    ], widget);

    expect(find.byType(TabBarView), findsOneWidget);
    Finder closeBtn = find.byType(SvgPicture);

    SvgPicture iconClose = widgetTester.widget(closeBtn);
    BytesLoader bytesLoader = iconClose.bytesLoader;
    expect(bytesLoader, isA<SvgAssetLoader>());
    expect((bytesLoader as SvgAssetLoader).assetName, 'assets/icons/close.svg');

    await widgetTester.tap(closeBtn);
    await widgetTester.pumpAndSettle();

    verify(photoSelectionCubit.selectedItemCount).called(1);
    verify(lostDataBottomSheetCubit.onCloseSelectPhotoBottomSheetTapped(0))
        .called(1);

    // select photo bottom sheet is dismissed
    expect(find.byType(SelectPhotoBottomSheet), findsNothing);
  });

  group('lost data bottom sheet', () {
    testWidgets(
        'given lost data bottom sheet is displayed'
        'when user taps no button'
        'then bottom sheet is dismissed', (widgetTester) async {
      when(selectPhotoCubit.state).thenAnswer((_) => const PhotosLoaded([]));

      when(lostDataBottomSheetCubit.state)
          .thenAnswer((_) => OpenLostDataBottomSheet());
      when(lostDataBottomSheetCubit.stream)
          .thenAnswer((_) => Stream.value(OpenLostDataBottomSheet()));

      when(photoSelectionCubit.selectedItemCount).thenReturn(1);

      const Widget widget = SelectPhotoBody();

      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<SelectPhotoCubit>(
          create: (context) => selectPhotoCubit,
        ),
        BlocProvider<PhotoSelectionCubit>(
          create: (context) => photoSelectionCubit,
        ),
        BlocProvider<LostDataBottomSheetCubit>(
          create: (context) => lostDataBottomSheetCubit,
        ),
      ], widget);
      expect(find.byType(SelectPhotoBody), findsOneWidget);

      // Verify that the HsWarningBottomSheetView is displayed
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
      Finder noBtn = find.widgetWithText(PrimaryButton, 'No');
      await widgetTester.tap(noBtn);
      await widgetTester.pumpAndSettle();

      // Verify that the HsWarningBottomSheetView is dismissed
      expect(find.byType(HsWarningBottomSheetView), findsNothing);
    });

    testWidgets(
        'given lost data bottom sheet is displayed'
        'when user taps yes button'
        'then both lost data and select photo bottom sheet are dismissed',
        (widgetTester) async {
      when(selectPhotoCubit.state).thenAnswer((_) => const PhotosLoaded([]));

      when(lostDataBottomSheetCubit.state)
          .thenAnswer((_) => OpenLostDataBottomSheet());
      when(lostDataBottomSheetCubit.stream)
          .thenAnswer((_) => Stream.value(OpenLostDataBottomSheet()));

      when(photoSelectionCubit.selectedItemCount).thenReturn(1);

      const Widget widget = SelectPhotoBody();

      await widgetTester.multiBlocWrapAndPump([
        BlocProvider<SelectPhotoCubit>(
          create: (context) => selectPhotoCubit,
        ),
        BlocProvider<PhotoSelectionCubit>(
          create: (context) => photoSelectionCubit,
        ),
        BlocProvider<LostDataBottomSheetCubit>(
          create: (context) => lostDataBottomSheetCubit,
        ),
      ], widget);
      expect(find.byType(SelectPhotoBody), findsOneWidget);

      // Verify that the HsWarningBottomSheetView is displayed
      expect(find.byType(HsWarningBottomSheetView), findsOneWidget);
      Finder yesBtn = find.widgetWithText(SecondaryButton, 'Yes');
      await widgetTester.tap(yesBtn);
      await widgetTester.pumpAndSettle();

      // Verify that the HsWarningBottomSheetView is dismissed
      expect(find.byType(HsWarningBottomSheetView), findsNothing);
      // select photo bottom sheet is dismissed
      expect(find.byType(SelectPhotoBottomSheet), findsNothing);
    });
  });

  testWidgets(
      "given user has images on their device but user hasn't selected any image,"
      'when load AllPhotosView,'
      'then the the Selected Image button in GridView is disabled',
      (widgetTester) async {
    when(selectPhotoCubit.state).thenAnswer((realInvocation) => PhotosLoaded([
          MockAssetEntity(),
          MockAssetEntity(),
          MockAssetEntity(),
          MockAssetEntity(),
          MockAssetEntity()
        ]));
    when(photoSelectionCubit.state)
        .thenAnswer((realInvocation) => const PhotoSelectionUpdated({}, false));

    const Widget widget = AllPhotosView();

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump([
          BlocProvider<SelectPhotoCubit>(
            create: (context) => selectPhotoCubit,
          ),
          BlocProvider<PhotoSelectionCubit>(
            create: (context) => photoSelectionCubit,
          )
        ], widget));
    await widgetTester.pumpAndSettle();

    expect(find.byType(GridView), findsOneWidget);

    final Finder btnFinder = find.byType(PrimaryButton);
    expect(btnFinder, findsOneWidget);
    final PrimaryButton buttonWidget = widgetTester.widget(btnFinder);
    expect(buttonWidget.onPressed, null);
  });

  testWidgets(
      'given user has images on their device but user has selected 3 images,'
      'when load AllPhotosView,'
      'then the the Selected Image button in GridView is disabled',
      (widgetTester) async {
    when(selectPhotoCubit.state).thenAnswer((realInvocation) => PhotosLoaded([
          MockAssetEntity(),
          MockAssetEntity(),
          MockAssetEntity(),
          MockAssetEntity(),
          MockAssetEntity()
        ]));
    when(photoSelectionCubit.state).thenAnswer((realInvocation) =>
        const PhotoSelectionUpdated({'a', 'b', 'c'}, false));

    const Widget widget = AllPhotosView();

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump([
          BlocProvider<SelectPhotoCubit>(
            create: (context) => selectPhotoCubit,
          ),
          BlocProvider<PhotoSelectionCubit>(
            create: (context) => photoSelectionCubit,
          )
        ], widget));
    await widgetTester.pumpAndSettle();

    expect(find.byType(GridView), findsOneWidget);

    final Finder btnFinder = find.byType(PrimaryButton);
    expect(btnFinder, findsOneWidget);
    final PrimaryButton buttonWidget = widgetTester.widget(btnFinder);
    expect(buttonWidget.onPressed, null);
  });

  testWidgets(
      'given user has images on their device but user has selected 4 images,'
      'when load AllPhotosView,'
      'then the Selected Image button in GridView is enabled',
      (widgetTester) async {
    when(selectPhotoCubit.state).thenAnswer((realInvocation) => PhotosLoaded([
          MockAssetEntity(),
          MockAssetEntity(),
          MockAssetEntity(),
          MockAssetEntity(),
          MockAssetEntity()
        ]));
    when(photoSelectionCubit.state).thenAnswer((realInvocation) =>
        const PhotoSelectionUpdated({'a', 'b', 'c', 'd'}, true));

    const Widget widget = AllPhotosView();

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump([
          BlocProvider<SelectPhotoCubit>(
            create: (context) => selectPhotoCubit,
          ),
          BlocProvider<PhotoSelectionCubit>(
            create: (context) => photoSelectionCubit,
          )
        ], widget));
    await widgetTester.pumpAndSettle();

    expect(find.byType(GridView), findsOneWidget);

    final Finder btnFinder = find.byType(PrimaryButton);
    expect(btnFinder, findsOneWidget);
    final PrimaryButton buttonWidget = widgetTester.widget(btnFinder);
    expect(buttonWidget.onPressed != null, true);
  });

  testWidgets(
      'given user has selected 4 images,'
      'when user tap on submit button,'
      'then the select images bottom sheet will be closed.',
      (widgetTester) async {
    when(selectPhotoCubit.state).thenAnswer((realInvocation) => PhotosLoaded([
          MockAssetEntity(),
          MockAssetEntity(),
          MockAssetEntity(),
          MockAssetEntity(),
          MockAssetEntity()
        ]));
    when(photoSelectionCubit.state).thenAnswer((realInvocation) =>
        const PhotoSelectionUpdated({'a', 'b', 'c', 'd'}, true));

    const Widget widget = AllPhotosView();

    await mockNetworkImagesFor(() => widgetTester.multiBlocWrapAndPump([
          BlocProvider<SelectPhotoCubit>(
            create: (context) => selectPhotoCubit,
          ),
          BlocProvider<PhotoSelectionCubit>(
            create: (context) => photoSelectionCubit,
          )
        ], widget));
    await widgetTester.pumpAndSettle();

    expect(find.byType(GridView), findsOneWidget);

    final Finder btnFinder = find.byType(PrimaryButton);
    expect(btnFinder, findsOneWidget);

    await widgetTester.tap(btnFinder);
    await widgetTester.pumpAndSettle();

    expect(find.byType(SelectPhotoBottomSheet), findsNothing);
  });
}
