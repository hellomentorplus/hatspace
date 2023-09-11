import 'package:equatable/equatable.dart';

class PropertyDetailInteractionState extends Equatable {
  const PropertyDetailInteractionState();

  @override
  List<Object> get props => [];
}

class PropertyDetailInteractionInitial extends PropertyDetailInteractionState {}

class ShowLoginBottomModal extends PropertyDetailInteractionState {}

class CloseBottomModal extends PropertyDetailInteractionState {}

class NavigateToBooingInspectionScreen extends PropertyDetailInteractionState {}

class RequestTenantRoles extends PropertyDetailInteractionState {}
