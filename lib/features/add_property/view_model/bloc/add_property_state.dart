part of 'add_property_bloc.dart';

abstract class AddPropertyState {
  PropertyTypes propertyTypes;
  DateTime availableDate;
  AddPropertyState(this.propertyTypes, this.availableDate);
}

class AddPropertyInitial extends AddPropertyState {
  AddPropertyInitial() : super(PropertyTypes.house, DateTime.now());
}

class PropertyTypeSelectedState extends AddPropertyState {
  PropertyTypeSelectedState(PropertyTypes type, DateTime date)
      : super(type, date);
}
