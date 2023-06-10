part of 'property_infor_cubit.dart';

abstract class PropertyInforState {
  final AustraliaStates selectedState;
  const PropertyInforState(this.selectedState);
}

class PropertyInforInitial extends PropertyInforState {
  const PropertyInforInitial():super(AustraliaStates.invalid);

}

 class SaveSelectedState extends PropertyInforState{
  const SaveSelectedState(super.selectedState);
 }