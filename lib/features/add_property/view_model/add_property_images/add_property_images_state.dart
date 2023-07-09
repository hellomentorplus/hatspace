part of 'add_property_images_cubit.dart';

abstract class AddPropertyImagesState extends Equatable {
  const AddPropertyImagesState();
}

class AddPropertyImagesInitial extends AddPropertyImagesState {
  @override
  List<Object?> get props => [];
}

class PhotoPermissionGranted extends AddPropertyImagesState {
  @override
  List<Object?> get props => [];
}

class PhotoPermissionDenied extends AddPropertyImagesState {
  @override
  List<Object?> get props => [];
}

class PhotoPermissionDeniedForever extends AddPropertyImagesState {
  @override
  List<Object?> get props => [];
}

class CancelPhotoAccess extends AddPropertyImagesState {
  @override
  List<Object?> get props => [];
}

class OpenSelectPhotoScreen extends AddPropertyImagesState {
  @override
  List<Object?> get props => [];
}

class OpenSettingScreen extends AddPropertyImagesState {
  @override
  List<Object?> get props => [];
}

class ClosePhotoPermissionBottomSheet extends AddPropertyImagesState {
  @override
  List<Object?> get props => [];
}

class CloseSelectPhotoBottomSheet extends AddPropertyImagesState {
  @override
  List<Object?> get props => [];
}
