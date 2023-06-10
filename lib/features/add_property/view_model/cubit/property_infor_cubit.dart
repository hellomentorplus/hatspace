import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/data/property_data.dart';

part 'property_infor_state.dart';

class PropertyInforCubit extends Cubit<PropertyInforState> {
    PropertyInforCubit() : super(const PropertyInforInitial());

  void saveSelectedState(AustraliaStates selectedState){
    print('save $selectedState');
    emit(SaveSelectedState(selectedState));
  }
}

