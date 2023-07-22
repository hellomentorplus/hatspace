import 'package:flutter_bloc/flutter_bloc.dart';

part 'photo_selection_state.dart';

class PhotoSelectionCubit extends Cubit<PhotoSelectionState> {
  final Set<String> _selectionStates = {};

  PhotoSelectionCubit() : super(PhotoSelectionInitial());

  void updateSelection(String thumbnail) {
    if (_selectionStates.contains(thumbnail)) {
      // remove selection
      _selectionStates.remove(thumbnail);
    } else if (_selectionStates.length < 10) {
      _selectionStates.add(thumbnail);
    }

    emit(PhotoSelectionUpdated(_selectionStates, _selectionStates.length >= 4));
  }

  void onClosePhotoBottomSheetTapped() {
    emit((_selectionStates.isEmpty
        ? CloseLostDataBottomSheet()
        : OpenLostDataBottomSheet()));
  }

  void closeLostDataBottomSheet() {
    emit(CloseLostDataBottomSheet());
  }
}
