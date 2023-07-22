part of 'photo_selection_cubit.dart';

abstract class PhotoSelectionState {
  const PhotoSelectionState();
}

class PhotoSelectionInitial extends PhotoSelectionState {}

class PhotoSelectionUpdated extends PhotoSelectionState {
  final Set<String> selectedItems;
  final bool enableUpload;

  const PhotoSelectionUpdated(this.selectedItems, this.enableUpload);

  int? getItemSelection(String thumbnail) => selectedItems.contains(thumbnail)
      ? selectedItems.toList().indexOf(thumbnail) + 1
      : null;

  int get count => selectedItems.length;
}
