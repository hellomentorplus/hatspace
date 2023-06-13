import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/property_data.dart';

import 'property_infor_state.dart';

class PropertyInforCubit extends Cubit<PropertyInforState> {
  PropertyInforCubit() : super(const PropertyInforInitial());

  void saveSelectedState(AustraliaStates savedState) {
    emit(SaveSelectedState(savedState, state.saveRentPeriod));
  }

  void saveMinimumRentPeriod(MinimumRentPeriod savedPeriod) {
    emit(SaveMinimumPeriodState(state.savedState, savedPeriod));
  }
}
