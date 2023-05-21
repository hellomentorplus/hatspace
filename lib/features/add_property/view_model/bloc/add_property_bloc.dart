import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/data/data.dart';

part 'add_property_event.dart';
part 'add_property_state.dart';

class AddPropertyBloc extends Bloc<AddPropertyEvent, AddPropertyState> {
  AddPropertyBloc() : super(AddPropertyInitial()) {
    on<AddPropertyEvent>((event, emit) {
      // TODO: implement event handler
    });
    PropertyTypes propertyTypes;
    on<SelectPropertyTypeEvent>((event, emit) {
      propertyTypes = PropertyTypes.values[event.position];
      emit(PropertyTypeSelectedState(propertyTypes));
    });

    on<OnUpdateAvailableEvent>((event, emit) {
      print("On update avaliable date");
      emit(PropertySelectedAvailableDate(event.currentDate));
    });

  }
}
