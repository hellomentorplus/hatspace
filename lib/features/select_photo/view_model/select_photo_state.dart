part of 'select_photo_cubit.dart';

class AssetData {
  final File file;

  AssetData(this.file);
}

abstract class SelectPhotoState extends Equatable {
  const SelectPhotoState();
}

class SelectPhotoInitial extends SelectPhotoState {
  @override
  List<Object> get props => [];
}

class PhotosLoaded extends SelectPhotoState {
  final List<AssetEntity> photos;

  const PhotosLoaded(this.photos);

  @override
  List<Object?> get props => [Pipe.createSync()];
}

class OpenLostDataBottomSheet extends SelectPhotoState {
  @override
  List<Object> get props => [];
}

class CloseLostDataBottomSheet extends SelectPhotoState {
  @override
  List<Object> get props => [];
}

class CloseSelectPhotoScreen extends SelectPhotoState {
  @override
  List<Object> get props => [];
}
