import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/features/add_property/view_model/cubit/add_property_state.dart';

enum NavigatePage { forward, reverse }

class AddPropertyCubit extends Cubit<AddPropertyState> {
  AddPropertyCubit() : super(const AddPropertyInitial());
  final List<bool> activePageList = [];
  void navigatePage(NavigatePage navType, int totalPages) {
    if (navType == NavigatePage.forward &&
        state.pageViewNumber < totalPages - 1) {
      emit(PageViewNavigationState(state.pageViewNumber + 1));
    }
    if (navType == NavigatePage.reverse && state.pageViewNumber > 0) {
      emit(PageViewNavigationState(state.pageViewNumber - 1));
      validateState(state.pageViewNumber);
    }
  }

  void enableNextButton() {
    if (activePageList.isEmpty) {
      activePageList.add(true);
    } else {
      activePageList[state.pageViewNumber] = true;
    }

    emit(NextButtonEnable(state.pageViewNumber, true));
  }

  void validateState(int pageNumber) {
    if (activePageList[pageNumber] == true) {
      emit(NextButtonEnable(state.pageViewNumber, true));
    } else {
      // Implement disable event
    }
  }
}
