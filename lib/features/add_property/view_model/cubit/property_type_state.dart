part of 'property_type_cubit.dart';

abstract class PropertyTypeState {
  PropertyTypes propertyTypes;
  DateTime availableDate;
  PropertyTypeState(this.propertyTypes, this.availableDate);
}

class PropertyTypeInitial extends PropertyTypeState {
   PropertyTypeInitial() :  super(PropertyTypes.house, DateTime.now());
}

class PropertyTypeSelectedState extends PropertyTypeState {
   PropertyTypeSelectedState(super.propertyTypes, super.availableDate);
}

class PropertyAvailableDate extends PropertyTypeState{
  PropertyAvailableDate(super.propertyTypes, super.availableDate);
}