import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/property_data.dart';

import 'property_infor_state.dart';

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
  List<Object?> get props => [state, rentPeriod];
}

class PropertyInforCubit extends Cubit<PropertyInforState> {
  PropertyInfor propertyInfor;
  PropertyInforCubit(this.propertyInfor) : super(PropertyInforInitial());

  void saveSelectedState(AustraliaStates savedState) {
    propertyInfor.saveState(savedState);
    print(propertyInfor);
    emit(SavePropertyInforFields(propertyInfor));
  }

  void saveMinimumRentPeriod(MinimumRentPeriod savedPeriod) {
    propertyInfor.saveRentPeriod(savedPeriod);
    emit(SavePropertyInforFields(propertyInfor));
  }
}
