import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hatspace/data/data.dart';

part 'add_property_event.dart';
part 'add_property_state.dart';

class AddPropertyBloc extends Bloc<AddPropertyEvent, AddPropertyState> {

  AddPropertyBloc() : super(AddPropertyInitial()) {
    // By default
   PropertyTypes propertyTypes = PropertyTypes.house;
   DateTime availableDate = DateTime.now();
    on<SelectPropertyTypeEvent>((event, emit) {
      print ("on update property type");
      propertyTypes = PropertyTypes.values[event.position];
      PropertyTypeSelectedState prop = PropertyTypeSelectedState(type: propertyTypes);
      emit(PropertyTypeSelectedState(type: propertyTypes,date: availableDate));
    });

    on<OnUpdateAvailableEvent>((event, emit) {
      availableDate= event.currentDate;
      print("On update avaliable date");
      emit(PropertyTypeSelectedState(date: event.currentDate,type: propertyTypes));
    });

  }
}
