part of 'add_property_bloc.dart';

abstract class AddPropertyEvent extends Equatable {
  const AddPropertyEvent();

  @override
  List<Object> get props => [];
}


class SelectPropertyTypeEvent extends AddPropertyEvent{
  final int position;
  const SelectPropertyTypeEvent(this.position);
  @override
  List<Object> get props => [];
}

class OnUpdateAvailableEvent extends AddPropertyEvent{
  DateTime currentDate = DateTime.now();
  OnUpdateAvailableEvent(DateTime date){
    currentDate = date;
  }
  @override
  List<Object> get props => [currentDate];
}