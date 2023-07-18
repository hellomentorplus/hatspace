import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_property_image_selected_state.dart';

class AddPropertyImageSelectedCubit extends Cubit<AddPropertyImageSelectedState> {
  AddPropertyImageSelectedCubit() : super(AddPropertyImageSelectedInitial());

  void onPhotosSelected(List<String>? photos) {
    if (photos == null) {
      return;
    }

    if (photos.isEmpty) {
      return;
    }

    // there are photos selected
    for (String s in photos) {
      print('SUESI path $s');
    }
  }
}