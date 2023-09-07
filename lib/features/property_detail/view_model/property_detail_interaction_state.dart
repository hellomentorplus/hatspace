import 'package:equatable/equatable.dart';

class PropertyDetailInteractionState extends Equatable {
  const PropertyDetailInteractionState();

  @override
  List<Object> get props => [];
}

 class PropertyDetailInteractionCubitInitial extends PropertyDetailInteractionState {}


class ShowLoginBottomModal extends PropertyDetailInteractionState{}
class CloseLoginBottomModal extends PropertyDetailInteractionState{}

class NavigateToBooingInspectionScreen extends PropertyDetailInteractionState{}