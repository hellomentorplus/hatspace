import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:hatspace/features/select_photo/view_model/photo_selection_cubit.dart';

void main() {
  blocTest('given path is not in list, when updateSelection, then path is added, and enableUpload is true',
    build: () => PhotoSelectionCubit(),
    act: (bloc) => bloc.updateSelection('thumbnail'),
    expect: () => [isA<PhotoSelectionUpdated>()],
    verify: (bloc) {
      PhotoSelectionUpdated state = bloc.state as PhotoSelectionUpdated;

      expect(state.selectedItems.contains('thumbnail'), isTrue);
      expect(state.enableUpload, isTrue);
    },
  );

  blocTest('given path is in list, when updateSelection, then path is removed',
    build: () => PhotoSelectionCubit()..updateSelection('thumbnail'),
    act: (bloc) => bloc.updateSelection('thumbnail'),
    expect: () => [isA<PhotoSelectionUpdated>()],
    verify: (bloc) {
      PhotoSelectionUpdated state = bloc.state as PhotoSelectionUpdated;

      expect(state.selectedItems.contains('thumbnail'), isFalse);
      expect(state.enableUpload, isFalse);
    },
  );
}