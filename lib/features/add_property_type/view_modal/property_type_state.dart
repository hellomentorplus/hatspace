part of 'property_type_cubit.dart';

abstract class PropertyTypeState extends Equatable {
  final PropertyTypes? propertyTypes;
  final DateTime availableDate;
  const PropertyTypeState(this.propertyTypes, this.availableDate);
}

class PropertyTypeInitial extends PropertyTypeState {
  PropertyTypeInitial() : super(null, DateTime.now());

  @override
  List<Object?> get props => [super.availableDate, super.propertyTypes];
}

class PropertyTypeSelectedState extends PropertyTypeState {
  const PropertyTypeSelectedState(super.propertyTypes, super.availableDate);
  @override
  List<Object?> get props => [super.availableDate, super.propertyTypes];
}

class PropertyAvailableDate extends PropertyTypeState {
  const PropertyAvailableDate(super.propertyTypes, super.availableDate);
  @override
  List<Object?> get props => [super.availableDate, super.propertyTypes];
}
