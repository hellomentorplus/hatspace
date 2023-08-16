import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:hatspace/features/add_property/view_model/add_property_images/add_property_image_selected_cubit.dart';

void main() {
  blocTest(
    'given photo list is null,'
    ' when call onPhotosSelected,'
    ' then do nothing',
    build: () => AddPropertyImageSelectedCubit(),
    act: (bloc) => bloc.onPhotosSelected(null),
    expect: () => [isA<OnPhotosCleared>()],
  );

  blocTest(
    'given photo list is empty, '
    'when call onPhotoSelected,'
    ' then do nothing',
    build: () => AddPropertyImageSelectedCubit(),
    act: (bloc) => bloc.onPhotosSelected([]),
    expect: () => [isA<OnPhotosCleared>()],
  );

  blocTest(
    'given photo list has less than 10 data,'
    ' when call onPhotoSelected,'
    ' then emit state with allowAddImage true',
    build: () => AddPropertyImageSelectedCubit(),
    act: (bloc) => bloc.onPhotosSelected(List.filled(9, 'path')),
    expect: () => [isA<PhotoSelectionReturned>()],
    verify: (bloc) {
      final PhotoSelectionReturned state = bloc.state as PhotoSelectionReturned;
      expect(state.paths.length, 9);
      expect(state.allowAddImage, isTrue);
    },
  );

  blocTest(
    'given photo list has 10 data,'
    ' when call onPhotoSelected,'
    ' then emit state with allowAddImage false',
    build: () => AddPropertyImageSelectedCubit(),
    act: (bloc) => bloc.onPhotosSelected(List.filled(10, 'path')),
    expect: () => [isA<PhotoSelectionReturned>()],
    verify: (bloc) {
      final PhotoSelectionReturned state = bloc.state as PhotoSelectionReturned;
      expect(state.paths.length, 10);
      expect(state.allowAddImage, isFalse);
    },
  );

  blocTest(
    'given photo list has more than 10 data,'
    ' when call onPhotoSelected,'
    ' then emit state with allowAddImage false',
    build: () => AddPropertyImageSelectedCubit(),
    act: (bloc) => bloc.onPhotosSelected(List.filled(11, 'path')),
    expect: () => [isA<PhotoSelectionReturned>()],
    verify: (bloc) {
      final PhotoSelectionReturned state = bloc.state as PhotoSelectionReturned;
      expect(state.paths.length, 11);
      expect(state.allowAddImage, isFalse);
    },
  );
}
