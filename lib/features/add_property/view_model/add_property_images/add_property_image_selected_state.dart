part of 'add_property_image_selected_cubit.dart';

abstract class AddPropertyImageSelectedState extends Equatable {
  const AddPropertyImageSelectedState();
}

class AddPropertyImageSelectedInitial extends AddPropertyImageSelectedState {
  @override
  List<Object> get props => [];
}

class PhotoSelectionReturned extends AddPropertyImageSelectedState {
  final List<String> paths;

  const PhotoSelectionReturned({required this.paths});

  @override
  List<Object?> get props => [...paths];

}