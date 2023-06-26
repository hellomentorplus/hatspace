import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/features/add_property/view_model/add_property_state.dart';

enum NavigatePage { forward, reverse }

class AddPropertyCubit extends Cubit<AddPropertyState> {
  AddPropertyCubit() : super(const AddPropertyInitial());

  /// Defines all value needed for a property
  int _bedrooms = 0;
  int _bathrooms = 0;
  int _parking = 0;

  int get bedrooms => _bedrooms;
  int get bathrooms => _bathrooms;
  int get parking => _parking;

  set bedrooms(int count) {
    _bedrooms = count;
    validateNextButtonState(state.pageViewNumber);
  }

  set bathrooms(int count) {
    _bathrooms = count;
    validateNextButtonState(state.pageViewNumber);
  }

  set parking(int count) {
    _parking = 0;
    validateNextButtonState(state.pageViewNumber);
  }

  /// navigate to next page
  void navigatePage(NavigatePage navType, int totalPages) {
    if (navType == NavigatePage.forward &&
        state.pageViewNumber < totalPages - 1) {
      emit(PageViewNavigationState(state.pageViewNumber + 1));
    }
    if (navType == NavigatePage.reverse && state.pageViewNumber > 0) {
      emit(PageViewNavigationState(state.pageViewNumber - 1));
    }
    validateNextButtonState(state.pageViewNumber);
  }

  /// Validate next button
  void validateNextButtonState(int pageNumber) {
    bool nextButtonEnable = false;
    switch (pageNumber) {
      case 0: // choose kind of place
        nextButtonEnable = true;
        break;
      case 1: // property info
        // TODO add validation logic for property info
        nextButtonEnable = true;
        break;
      case 2:
        nextButtonEnable = _bedrooms + _bathrooms + _parking > 0;
        break;
      // TODO add validation logic for other screens
    }

    emit(NextButtonEnable(state.pageViewNumber, nextButtonEnable));
  }
}
