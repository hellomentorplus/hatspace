import 'package:hatspace/data/property_data.dart';

abstract class SelectStateState {
  final AustraliaStates australiaState;
  SelectStateState(this.australiaState);
}

class StateSelectionStateInitial extends SelectStateState {
  StateSelectionStateInitial() : super(AustraliaStates.nsw);
}

class SelectedState extends SelectStateState {
  SelectedState(super.state);
}
