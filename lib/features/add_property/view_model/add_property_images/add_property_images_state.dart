part of 'add_property_images_cubit.dart';

abstract class AddPropertyImagesState extends Equatable {
  const AddPropertyImagesState();

  @override
  List<Object?> get props => [];
}

class AddPropertyImagesInitial extends AddPropertyImagesState {}

class PhotoPermissionGranted extends AddPropertyImagesState {}

class PhotoPermissionDenied extends AddPropertyImagesState {}

class PhotoPermissionDeniedForever extends AddPropertyImagesState {}

class CancelPhotoAccess extends AddPropertyImagesState {}

class OpenSelectPhotoScreen extends AddPropertyImagesState {}

class OpenSettingScreen extends AddPropertyImagesState {}

class ClosePhotoPermissionBottomSheet extends AddPropertyImagesState {}

class CloseSelectPhotoBottomSheet extends AddPropertyImagesState {}
