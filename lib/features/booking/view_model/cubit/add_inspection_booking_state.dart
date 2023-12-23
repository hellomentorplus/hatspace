part of 'add_inspection_booking_cubit.dart';

class AddInspectionBookingState extends Equatable {
  const AddInspectionBookingState();

  @override
  List<Object> get props => [];
}

class AddInspectionBookingInitial extends AddInspectionBookingState {}

class BookingInspectionSuccess extends AddInspectionBookingState {
  @override
  List<Object> get props => [];
}

class BookInspectionButtonEnable extends AddInspectionBookingState {}

class RequestStartTimeSelection extends AddInspectionBookingState {}

class CloseStartTimeRequestMessage extends AddInspectionBookingState {}

class ShowDurationSelection extends AddInspectionBookingState {}

class CloseBottomSheet extends AddInspectionBookingState {}

class ShowUpdateProfileModal extends AddInspectionBookingState{}
