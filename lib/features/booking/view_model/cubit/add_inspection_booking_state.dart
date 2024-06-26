part of 'add_inspection_booking_cubit.dart';

class AddInspectionBookingState extends Equatable {
  const AddInspectionBookingState();

  @override
  List<Object> get props => [];
}

class AddInspectionBookingInitial extends AddInspectionBookingState {}

class BookingInspectionSuccess extends AddInspectionBookingState {
  final String inspectionId;
  const BookingInspectionSuccess({required this.inspectionId});
  @override
  List<Object> get props => [inspectionId];
}

class ShowStartTimeSelection extends AddInspectionBookingState {}

class BookInspectionButtonEnable extends AddInspectionBookingState {}

class RequestStartTimeSelection extends AddInspectionBookingState {}

class CloseStartTimeRequestMessage extends AddInspectionBookingState {}

class ShowDurationSelection extends AddInspectionBookingState {
  final bool isShowDuration;
  const ShowDurationSelection(this.isShowDuration);
  @override
  List<Object> get props => [isShowDuration];
}

class CloseBottomSheet extends AddInspectionBookingState {}

class ShowUpdateProfileModal extends AddInspectionBookingState {}

class UpdatePhoneNumberSuccessState extends AddInspectionBookingState {}

class BookingInspectionFail extends AddInspectionBookingState {}
