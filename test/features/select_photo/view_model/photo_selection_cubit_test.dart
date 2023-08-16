import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:hatspace/features/select_photo/view_model/photo_selection_cubit.dart';

void main() {
  blocTest(
    'given path is not in list, when updateSelection, then path is added, and enableUpload is true',
    build: () => PhotoSelectionCubit(),
    act: (bloc) => bloc.updateSelection('thumbnail'),
    expect: () => [isA<PhotoSelectionUpdated>()],
    verify: (bloc) {
      PhotoSelectionUpdated state = bloc.state as PhotoSelectionUpdated;

      expect(state.selectedItems.contains('thumbnail'), isTrue);
      expect(state.enableUpload, isTrue);
    },
  );

  blocTest(
    'given path is in list, when updateSelection, then path is removed',
    build: () => PhotoSelectionCubit()..updateSelection('thumbnail'),
    act: (bloc) => bloc.updateSelection('thumbnail'),
    expect: () => [isA<PhotoSelectionUpdated>()],
    verify: (bloc) {
      PhotoSelectionUpdated state = bloc.state as PhotoSelectionUpdated;

      expect(state.selectedItems.contains('thumbnail'), isFalse);
      expect(state.enableUpload, isFalse);
    },
  );

  blocTest('given preset photos list is null,'
      'when loadPresetPhotos,'
      'then do nothing', build: () => PhotoSelectionCubit(),
  act: (bloc) => bloc.loadPresetPhotos(null),
    expect: () => [],
  );

  blocTest('given preset photos list is empty,'
      'when loadPresetPhotos,'
      'then do nothing', build: () => PhotoSelectionCubit(),
    act: (bloc) => bloc.loadPresetPhotos([]),
    expect: () => [],
  );

  blocTest('given preset photos list is not empty,'
      'when loadPresetPhotos,'
      'then emit PhotoSelectionUpdated', build: () => PhotoSelectionCubit(),
    act: (bloc) => bloc.loadPresetPhotos(['path1', 'path2']),
    expect: () => [isA<PhotoSelectionUpdated>()],
    verify: (bloc) {
      final PhotoSelectionUpdated state = bloc.state as PhotoSelectionUpdated;

      expect(state.count, 2);
      expect(state.enableUpload, true);
    },
  );
}
