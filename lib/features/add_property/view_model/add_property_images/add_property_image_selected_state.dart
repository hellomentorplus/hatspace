part of 'add_property_image_selected_cubit.dart';

abstract class AddPropertyImageSelectedState {
  const AddPropertyImageSelectedState();
}

class AddPropertyImageSelectedInitial extends AddPropertyImageSelectedState {
}

class OnPhotosCleared extends AddPropertyImageSelectedState {
}

class PhotoSelectionReturned extends AddPropertyImageSelectedState {
  final List<String> paths;
  final bool allowAddImage;

  const PhotoSelectionReturned(
      {required this.paths, required this.allowAddImage});
}
