import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/add_property/view_model/cubit/select_state_state.dart';

enum NavigatePage { forward, reverse }

class SelectStateCubit extends Cubit<SelectStateState> {
  SelectStateCubit() : super(StateSelectionStateInitial());

  void selectAustraliaState(AustraliaStates state) {
    emit(SelectedState(state));
  }
}
