import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/features/add_property/view_model/add_property_state.dart';

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
  AustraliaStates _australiaState = AustraliaStates.invalid;

  set australiaState(AustraliaStates australiaState) {
    _australiaState = australiaState;
    validateNextButtonState(state.pageViewNumber);
  }

  AustraliaStates get australiaState => _australiaState;

  MinimumRentPeriod _rentPeriod = MinimumRentPeriod.invalid;
  set rentPeriod(MinimumRentPeriod rentPeriod) {
    _rentPeriod = rentPeriod;
    validateNextButtonState(state.pageViewNumber);
  }

  MinimumRentPeriod get rentPeriod => _rentPeriod;

  String _propertyName = '';
  set propertyName(String name) {
    _propertyName = name;
    validateNextButtonState(state.pageViewNumber);
  }

  String get propertyName => _propertyName;

  double? _price;
  set price(double? price) {
    _price = price;
    validateNextButtonState(state.pageViewNumber);
  }

  double? get price => _price;

  String _suburb = '';
  set suburb(String value) {
    _suburb = value;
    validateNextButtonState(state.pageViewNumber);
  }

  String get suburb => _suburb;

  int? _postalCode;
  set postalCode(int? value) {
    _postalCode = value;
    validateNextButtonState(state.pageViewNumber);
  }

  int? get postalCode => _postalCode;

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
  final List<bool> activePageList = [];

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
        nextButtonEnable = true;
        break;
      // TODO add validation logic for other screens
    }

    emit(NextButtonEnable(state.pageViewNumber, nextButtonEnable));
  }

  /// handle back button
  void onBackPressed(int totalPages) {
    if (state.pageViewNumber > 0) {
      navigatePage(NavigatePage.reverse, totalPages);
    } else if (state.pageViewNumber == 0) {
      emit(ExitAddPropertyFlow(state.pageViewNumber));
    }
  }
}
