part of 'property_infor_cubit.dart';

abstract class PropertyInforState {
  final AustraliaStates savedState;
  const PropertyInforState(this.savedState);
}

class PropertyInforInitial extends PropertyInforState {
  const PropertyInforInitial() : super(AustraliaStates.invalid);
}

class SaveSelectedState extends PropertyInforState {
  const SaveSelectedState(super.savedState);
}
