part of 'add_property_bloc.dart';

abstract class AddPropertyEvent extends Equatable {
  const AddPropertyEvent();
}

class SelectPropertyTypeEvent extends AddPropertyEvent {
  final int position;
  const SelectPropertyTypeEvent(this.position);
  @override
  List<Object> get props => [position];
}

class OnUpdateAvailableEvent extends AddPropertyEvent {
  final DateTime currentDate;
  const OnUpdateAvailableEvent(this.currentDate);
  @override
  List<Object> get props => [currentDate];
}
