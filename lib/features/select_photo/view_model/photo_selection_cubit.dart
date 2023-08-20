import 'package:flutter_bloc/flutter_bloc.dart';

part 'photo_selection_state.dart';

class PhotoSelectionCubit extends Cubit<PhotoSelectionState> {
  final Set<String> _selectionStates = {};

  PhotoSelectionCubit() : super(PhotoSelectionInitial());

  void loadPresetPhotos(List<String>? preset) {
    if (preset == null) {
      return;
    }

    if (preset.isEmpty) {
      _selectionStates.clear();
      return;
    }

    _selectionStates.addAll(preset);
    emit(PhotoSelectionUpdated(_selectionStates, _selectionStates.isNotEmpty));
  }

  void updateSelection(String thumbnail) {
    if (_selectionStates.contains(thumbnail)) {
      // remove selection
      _selectionStates.remove(thumbnail);
    } else if (_selectionStates.length < 10) {
      _selectionStates.add(thumbnail);
    }

    emit(PhotoSelectionUpdated(_selectionStates, _selectionStates.isNotEmpty));
  }

  int get selectedItemCount => _selectionStates.length;
}
