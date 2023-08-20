import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_property_image_selected_state.dart';

class AddPropertyImageSelectedCubit
    extends Cubit<AddPropertyImageSelectedState> {
  AddPropertyImageSelectedCubit() : super(AddPropertyImageSelectedInitial());

  void onPhotosSelected(List<String>? photos) async {
    if (photos == null) {
      emit(OnPhotosCleared());
      return;
    }

    if (photos.isEmpty) {
      emit(OnPhotosCleared());
      return;
    }

    // there are photos selected
    emit(PhotoSelectionReturned(
        paths: photos, allowAddImage: photos.length < 10));
  }

  void removePhoto(List<String>? photos, String toBeRemoved) {
    photos?.removeWhere((element) => element == toBeRemoved);

    onPhotosSelected(photos);
  }
}
