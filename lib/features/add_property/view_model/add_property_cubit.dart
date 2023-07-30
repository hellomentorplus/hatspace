import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/property_data.dart';

import 'package:hatspace/strings/l10n.dart';

part 'add_property_state.dart';

enum NavigatePage { forward, reverse }

enum ButtonLabel {
  next,
  previewAndSubmit;

  String get label {
    switch (this) {
      case ButtonLabel.next:
        return HatSpaceStrings.current.next;
      case ButtonLabel.previewAndSubmit:
        return HatSpaceStrings.current.previewAndSubmit;
    }
  }
}

class AddPropertyCubit extends Cubit<AddPropertyState> {
  AddPropertyCubit() : super(const AddPropertyInitial());
  bool isAddPropertyFlowInteracted = false;

  /// Defines all value needed for a property
  /// 1. Choose kind of place
  PropertyTypes _type = PropertyTypes.house;
  DateTime _availableDate = DateTime.now();

  PropertyTypes get propertyType => _type;

  set propertyType(PropertyTypes type) {
    if (_type != type) {
      isAddPropertyFlowInteracted = true;
    }
    _type = type;
    validateNextButtonState(state.pageViewNumber);
  }

  DateTime get availableDate => _availableDate;

  set availableDate(DateTime dateTime) {
    isAddPropertyFlowInteracted = true;
    _availableDate = dateTime;
    validateNextButtonState(state.pageViewNumber);
  }

  /// 2. Property info
  AustraliaStates _australiaState = AustraliaStates.invalid;

  set australiaState(AustraliaStates australiaState) {
    isAddPropertyFlowInteracted = true;
    _australiaState = australiaState;
    validateNextButtonState(state.pageViewNumber);
  }

  AustraliaStates get australiaState => _australiaState;

  MinimumRentPeriod _rentPeriod = MinimumRentPeriod.invalid;

  set rentPeriod(MinimumRentPeriod rentPeriod) {
    isAddPropertyFlowInteracted = true;
    _rentPeriod = rentPeriod;
    validateNextButtonState(state.pageViewNumber);
  }

  MinimumRentPeriod get rentPeriod => _rentPeriod;

  String _propertyName = '';

  set propertyName(String name) {
    isAddPropertyFlowInteracted = true;
    _propertyName = name;
    validateNextButtonState(state.pageViewNumber);
  }

  String get propertyName => _propertyName;

  double? _price;

  set price(double? price) {
    isAddPropertyFlowInteracted = true;
    _price = price;
    validateNextButtonState(state.pageViewNumber);
  }

  double? get price => _price;

  String _suburb = '';

  set suburb(String value) {
    isAddPropertyFlowInteracted = true;
    _suburb = value;
    validateNextButtonState(state.pageViewNumber);
  }

  String get suburb => _suburb;

  int? _postalCode;

  set postalCode(int? value) {
    isAddPropertyFlowInteracted = true;
    _postalCode = value;
    validateNextButtonState(state.pageViewNumber);
  }

  int? get postalCode => _postalCode;

  String _unitNumber = '';
  String get unitNumber => _unitNumber;
  set unitNumber(String s) {
    _unitNumber = s;
    validateNextButtonState(state.pageViewNumber);
  }

  String _address = '';
  String get address => _address;
  set address(String a) {
    _address = a;
    validateNextButtonState(state.pageViewNumber);
  }

  /// 3. Rooms
  int _bedrooms = 0;
  int _bathrooms = 0;
  int _parking = 0;

  int get bedrooms => _bedrooms;

  int get bathrooms => _bathrooms;

  int get parking => _parking;

  set bedrooms(int count) {
    isAddPropertyFlowInteracted = true;
    _bedrooms = count;
    validateNextButtonState(state.pageViewNumber);
  }

  set bathrooms(int count) {
    isAddPropertyFlowInteracted = true;
    _bathrooms = count;
    validateNextButtonState(state.pageViewNumber);
  }

  set parking(int count) {
    isAddPropertyFlowInteracted = true;
    _parking = count;
    validateNextButtonState(state.pageViewNumber);
  }

  /// 4. Features
  List<Feature> _features = [];

  List<Feature> get features => _features;

  set features(List<Feature> list) {
    isAddPropertyFlowInteracted = true;
    _features = list;
    validateNextButtonState(state.pageViewNumber);
  }

  /// 5. Photos
  List<String> _photos = [];
  List<String> get photos => _photos;
  set photos(List<String> list) {
    _photos = list;
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
    bool showRightChevron = true;
    ButtonLabel label = ButtonLabel.next;
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
      case 4: // add images
        label = ButtonLabel.previewAndSubmit;
        showRightChevron = false;
        nextButtonEnable = _photos.length >= 4;
        break;
      // TODO add validation logic for other screens
    }
    emit(NextButtonEnable(
        state.pageViewNumber, nextButtonEnable, label, showRightChevron));
  }

  /// handle back button
  void onBackPressed(int totalPages) {
    if (state.pageViewNumber > 0) {
      navigatePage(NavigatePage.reverse, totalPages);
    } else if (state.pageViewNumber == 0) {
      onShowLostDataModal();
    }
  }

  // Show warning modal
  void onResetData() =>
      emit(const ExitAddPropertyFlow(0)); // handle logic to reset data

  void onShowLostDataModal() {
    // check pageViewNumber != choosekindofplace screen
    if (state.pageViewNumber == 0) {
      // verify whether isPropertyTypeScreen get interacted
      if (isAddPropertyFlowInteracted) {
        emit(OpenLostDataWarningModal(state.pageViewNumber));
      } else {
        emit(ExitAddPropertyFlow(state.pageViewNumber));
      }
    } else {
      emit(OpenLostDataWarningModal(state.pageViewNumber));
    }
  }

  void onCloseLostDataModal() {
    // Verify next button enable again
    validateNextButtonState(state.pageViewNumber);
  }
}
