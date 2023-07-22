part of 'image_thumbnail_cubit.dart';

abstract class ImageThumbnailState extends Equatable {
  const ImageThumbnailState();
}

class ImageThumbnailInitial extends ImageThumbnailState {
  @override
  List<Object> get props => [];
}

class ThumbnailError extends ImageThumbnailState {
  @override
  List<Object?> get props => [];
}

class ThumbnailLoaded extends ImageThumbnailState {
  final File thumbnail;
  final String originalPath;
  final int width;
  final int height;

  const ThumbnailLoaded(
      {required this.thumbnail,
      required this.originalPath,
      required this.width,
      required this.height});

  @override
  List<Object?> get props => [thumbnail];
}
