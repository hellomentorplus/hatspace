import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/features/select_photo/view/select_photo_bottom_sheet.dart';
import 'package:hatspace/features/select_photo/view_model/select_photo_cubit.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../widget_tester_extension.dart';
import 'select_photo_bottom_sheet_test.mocks.dart';

@GenerateMocks([SelectPhotoCubit])
void main() async {
  await HatSpaceStrings.load(const Locale('en'));

  final MockSelectPhotoCubit selectPhotoCubit = MockSelectPhotoCubit();

  setUp(() {
    when(selectPhotoCubit.state).thenReturn(SelectPhotoInitial());
    when(selectPhotoCubit.stream)
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
      ' when load AllPhotosView,'
      ' then GridView is visible', (widgetTester) async {
    when(selectPhotoCubit.state)
        .thenAnswer((realInvocation) => const PhotosLoaded([]));

    const Widget widget = AllPhotosView();

    await mockNetworkImagesFor(() => widgetTester
        .blocWrapAndPump<SelectPhotoCubit>(selectPhotoCubit, widget));
    await widgetTester.pumpAndSettle();

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
      ' when load AllPhotosView,'
      ' then GridView is not visible', (widgetTester) async {
    when(selectPhotoCubit.state)
        .thenAnswer((realInvocation) => SelectPhotoInitial());

    const Widget widget = AllPhotosView();

    await mockNetworkImagesFor(() => widgetTester
        .blocWrapAndPump<SelectPhotoCubit>(selectPhotoCubit, widget));
    await widgetTester.pumpAndSettle();

    expect(find.byType(GridView), findsNothing);
  });
}
