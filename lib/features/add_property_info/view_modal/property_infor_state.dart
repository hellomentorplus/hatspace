import 'package:equatable/equatable.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/add_property_info/view_modal/property_infor_cubit.dart';

abstract class PropertyInforState extends Equatable {
  final PropertyInfor propertyInfo;
  const PropertyInforState(this.propertyInfo);
}

class PropertyInforInitial extends PropertyInforState {
  PropertyInforInitial()
      : super(
            PropertyInfor(AustraliaStates.invalid, MinimumRentPeriod.invalid));
  @override
  List<Object?> get props => [propertyInfo];
}

class SavePropertyInforFields extends PropertyInforState {
  const SavePropertyInforFields(super.propertyInfo);
  @override
  List<Object?> get props => [propertyInfo.rentPeriod, propertyInfo.state];
}

class SaveSelectedState extends PropertyInforState {
  const SaveSelectedState(super.propertyInfo);
  @override
  List<Object?> get props => [super.propertyInfo];
}

class SaveMinimumPeriodState extends PropertyInforState {
  const SaveMinimumPeriodState(super.propertyInfo);
  @override
  List<Object?> get props => [super.propertyInfo];
}
