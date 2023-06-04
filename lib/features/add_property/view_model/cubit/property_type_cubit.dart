import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/data/data.dart';

part 'property_type_state.dart';


class PropertyTypeCubit extends Cubit<PropertyTypeState> {
  PropertyTypeCubit() : super(PropertyTypeInitial());

    void selectPropertyTypeEvent(int position) {
    PropertyTypes propertyTypes = PropertyTypes.values[position];
    emit(PropertyTypeSelectedState(propertyTypes, state.availableDate));
  }

  void selectAvailableDate (DateTime availableDate){
    emit(PropertyAvailableDate(state.propertyTypes, availableDate));
  }
}
