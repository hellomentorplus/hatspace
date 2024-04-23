part of 'inspection_cubit.dart';

abstract class InspectionState extends Equatable {
  const InspectionState();

  @override
  List<Object?> get props => [];
}

class InspectionInitial extends InspectionState {}

class GetUserRolesFailed extends InspectionState {}

class InspectionLoaded extends InspectionState {
  final List<DisplayItem> items;

  const InspectionLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class NoBookedInspection extends InspectionState {
  @override
  List<Object?> get props => [];
}

class InspectionItem extends InspectionState {
  final Inspection inspection;
  final Property property;
  final UserDetail userDetail;
  const InspectionItem(this.inspection, this.property, this.userDetail);
  @override
  List<Object?> get props => [inspection, property, userDetail];
}
