import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/features/select_photo/view_model/lost_data_bottom_sheet_cubit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  blocTest(
    'given selectedItemCount is 1,'
    'when onCloseSelectPhotoBottomSheetTapped,'
    'then emit state is OpenLostDataBottomSheet',
    build: () => LostDataBottomSheetCubit(),
    act: (bloc) => bloc.onCloseSelectPhotoBottomSheetTapped(1),
    expect: () => [isA<OpenLostDataBottomSheet>()],
  );

  blocTest(
    'given selectedItemCount is 0,'
    'when onCloseSelectPhotoBottomSheetTapped,'
    'then emit state is ExitSelectPhoto',
    build: () => LostDataBottomSheetCubit(),
    act: (bloc) => bloc.onCloseSelectPhotoBottomSheetTapped(0),
    expect: () => [isA<ExitSelectPhoto>()],
  );

  blocTest(
    'when closeLostDataBottomSheet,'
    'then emit state is CloseLostDataBottomSheet',
    build: () => LostDataBottomSheetCubit(),
    act: (bloc) => bloc.closeLostDataBottomSheet(),
    expect: () => [isA<CloseLostDataBottomSheet>()],
  );

  blocTest(
    'when closeLostDataBottomSheet,'
    'then emit state is CloseLostDataBottomSheet',
    build: () => LostDataBottomSheetCubit(),
    act: (bloc) => bloc.closeLostDataBottomSheet(),
    expect: () => [isA<CloseLostDataBottomSheet>()],
  );

  blocTest(
    'when closeSelectPhotoBottomSheet,'
    'then emit state is ExitSelectPhoto',
    build: () => LostDataBottomSheetCubit(),
    act: (bloc) => bloc.closeSelectPhotoBottomSheet(),
    expect: () => [isA<ExitSelectPhoto>()],
  );
}
