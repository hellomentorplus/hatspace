part of 'add_property_bloc.dart';

abstract class AddPropertyState{
    final PropertyTypes propertyTypes;
  final DateTime availableDate;
  AddPropertyState({
    PropertyTypes? type, 
    DateTime? date
    }):propertyTypes = type ?? PropertyTypes.house, availableDate = date?? DateTime.now();
  @override
  List<Object> get props => [propertyTypes, availableDate];
}

class AddPropertyInitial extends AddPropertyState {
  PropertyTypes defaultPropertyType = PropertyTypes.house;
  DateTime defaultDateTime  = DateTime.now();
  AddPropertyInitial();
}

class PropertyTypeSelectedState extends AddPropertyState {
  PropertyTypes selectedProperty;
  DateTime selectedAvailableDate;
  
  PropertyTypeSelectedState({
    PropertyTypes? type, 
    DateTime? date
    }):selectedProperty = type ?? PropertyTypes.house, selectedAvailableDate = date?? DateTime.now();
    // PropertyTypeSelectedState({
    // PropertyTypes? type, 
    // }):selectedProperty = type ?? PropertyTypes.house;
  @override
  List<Object> get props => [propertyTypes];
}


// class PropertySelectedAvailableDate extends AddPropertyState{
//   final  DateTime availableDate;
//   PropertySelectedAvailableDate(this.availableDate);
//   @override
//   List<Object> get props => [availableDate];
// }
