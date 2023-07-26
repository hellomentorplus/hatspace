import 'package:flutter_bloc/flutter_bloc.dart';

part 'lost_data_bottom_sheet_state.dart';

class LostDataBottomSheetCubit extends Cubit<LostDataBottomSheetState> {
  LostDataBottomSheetCubit() : super(LostDataBottomSheetInitial());

  void onCloseSelectPhotoBottomSheetTapped(int selectedItemCount) {
    emit((selectedItemCount == 0
        ? ExitSelectPhoto()
        : OpenLostDataBottomSheet()));
  }

  void closeLostDataBottomSheet() {
    emit(CloseLostDataBottomSheet());
  }

  void closeSelectPhotoBottomSheet() {
    emit(ExitSelectPhoto());
  }
}
