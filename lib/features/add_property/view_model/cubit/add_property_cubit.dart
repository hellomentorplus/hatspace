import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/features/add_property/view_model/cubit/add_property_state.dart';

enum NavigatePage { forward, preverse }

class AddPropertyCubit extends Cubit<AddPropertyState> {
  AddPropertyCubit() : super(const AddPropertyInitial());

  void navigatePage(NavigatePage navType, int totalPages) {
    if (navType == NavigatePage.forward &&
        state.pageViewNumber < totalPages - 1) {
      emit(PageViewNavigationState(state.pageViewNumber + 1));
    }
    if (navType == NavigatePage.preverse && state.pageViewNumber > 0) {
      emit(PageViewNavigationState(state.pageViewNumber - 1));
    }
  }

  void enableNextButton() {
    emit(NextButtonEnable(state.pageViewNumber, true));
  }
}
