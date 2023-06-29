import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/features/add_property/view_model/add_property_state.dart';
import 'package:hatspace/data/property_data.dart';

enum NavigatePage { forward, reverse }

class AddPropertyCubit extends Cubit<AddPropertyState> {
  AddPropertyCubit() : super(const AddPropertyInitial());

  /// Defines all value needed for a property
  /// 1. Choose kind of place
  PropertyTypes _type = PropertyTypes.house;
  DateTime _availableDate = DateTime.now();

  PropertyTypes get propertyType => _type;
  set propertyType(PropertyTypes type) {
    _type = type;
    validateNextButtonState(state.pageViewNumber);
  }

  DateTime get availableDate => _availableDate;
  set availableDate(DateTime dateTime) {
    _availableDate = dateTime;
    validateNextButtonState(state.pageViewNumber);
  }

  /// 2. Property info

  /// 3. Rooms
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
    _parking = count;
    validateNextButtonState(state.pageViewNumber);
  }

  /// 4. Features
  List<Feature> _features = [];
  List<Feature> get features => _features;
  set features(List<Feature> list) {
    _features = list;
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
      case 2: // rooms
        nextButtonEnable = _bedrooms + _bathrooms + _parking > 0;
        break;
      case 3: // features
        nextButtonEnable = _features.isNotEmpty;
        break;
      // TODO add validation logic for other screens
    }

    emit(NextButtonEnable(state.pageViewNumber, nextButtonEnable));
  }
}
