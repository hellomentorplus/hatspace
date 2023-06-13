import 'package:hatspace/data/property_data.dart';

abstract class PropertyInforState {
  final AustraliaStates savedState;
  final MinimumRentPeriod saveRentPeriod;
  const PropertyInforState(this.savedState, this.saveRentPeriod);
}

class PropertyInforInitial extends PropertyInforState {
  const PropertyInforInitial()
      : super(AustraliaStates.invalid, MinimumRentPeriod.invalid);
}

class SaveSelectedState extends PropertyInforState {
  const SaveSelectedState(super.savedState, super.saveRentPeriod);
}

class SaveMinimumPeriodState extends PropertyInforState {
  const SaveMinimumPeriodState(super.savedState, super.saveRentPeriod);
}
