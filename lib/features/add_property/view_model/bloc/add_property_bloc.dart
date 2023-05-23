import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/data.dart';

part 'add_property_event.dart';
part 'add_property_state.dart';

class AddPropertyBloc extends Bloc<AddPropertyEvent, AddPropertyState> {
  AddPropertyBloc() : super(AddPropertyInitial()) {
    on<SelectPropertyTypeEvent>((event, emit) {
      // print ("on update property type");
      PropertyTypes propertyTypes = PropertyTypes.values[event.position];
      emit(PropertyTypeSelectedState(propertyTypes, state.availableDate));
    });

    on<OnUpdateAvailableEvent>((event, emit) {
      // print("On update avaliable date");
      emit(PropertyTypeSelectedState(state.propertyTypes, event.currentDate));
    });
  }
}
