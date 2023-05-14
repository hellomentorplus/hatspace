part of 'add_property_bloc.dart';

abstract class AddPropertyState extends Equatable {
  const AddPropertyState();
  
  @override
  List<Object> get props => [];
}

class AddPropertyInitial extends AddPropertyState {}

class PropertyTypeSelectedState extends AddPropertyState {
  final PropertyTypes propertyTypes;
  const PropertyTypeSelectedState(this.propertyTypes);
  @override
  List<Object> get props => [propertyTypes];
}
