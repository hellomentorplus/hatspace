import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/property_data.dart';

import 'package:hatspace/features/add_property_info/view_modal/property_infor_state.dart';

// ignore: must_be_immutable
class PropertyInfor extends Equatable {
  AustraliaStates state;
  MinimumRentPeriod rentPeriod;
  PropertyInfor(this.state, this.rentPeriod);
  saveState(AustraliaStates newState) {
    state = newState;
  }

  saveRentPeriod(MinimumRentPeriod period) {
    rentPeriod = period;
  }

  @override
  // TODO: implement props
  List<Object> get props => [state, rentPeriod];
}

class PropertyInforCubit extends Cubit<PropertyInforState> {
  PropertyInfor propertyInfor =
      PropertyInfor(AustraliaStates.invalid, MinimumRentPeriod.invalid);
  PropertyInforCubit() : super(PropertyInforInitial());

  void saveSelectedState(AustraliaStates savedState) {
    emit(StartListenStateChange(propertyInfor));
    propertyInfor.saveState(savedState);
    emit(StartListenAustraliaStateChange(propertyInfor));
  }

  void saveMinimumRentPeriod(MinimumRentPeriod savedPeriod) {
    emit(StartListenStateChange(propertyInfor));
    propertyInfor.saveRentPeriod(savedPeriod);
  emit(StartListenRentPeriodChange(propertyInfor));

  }
}
