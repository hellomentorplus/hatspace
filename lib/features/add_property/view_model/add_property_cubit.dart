import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/photo/photo_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

import 'package:hatspace/strings/l10n.dart';

part 'add_property_state.dart';

enum NavigatePage { forward, reverse }

enum ButtonLabel {
  next,
  previewAndSubmit,
  submit;

  String get label {
    switch (this) {
      case ButtonLabel.next:
        return HatSpaceStrings.current.next;
      case ButtonLabel.previewAndSubmit:
        return HatSpaceStrings.current.previewAndSubmit;
      case ButtonLabel.submit:
        return HatSpaceStrings.current.submit;
    }
  }
}

class AddPropertyCubit extends Cubit<AddPropertyState> {
  AddPropertyCubit() : super(const AddPropertyInitial());

  bool isAddPropertyFlowInteracted = false;

  final StorageService _storageService = HsSingleton.singleton.get<StorageService>();
  final AuthenticationService _authenticationService = HsSingleton.singleton.get<AuthenticationService>();
  final PhotoService _photoService = HsSingleton.singleton.get<PhotoService>();

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

  String _description = '';
  String get description => _description;
  set description(String d) {
    _description = d;
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
    if (navType == NavigatePage.forward && state.pageViewNumber == totalPages - 1) {
      // handle submit logic
      _submitPropertyDetails();
    } else {
      // normal navigation
      if (navType == NavigatePage.forward &&
          state.pageViewNumber < totalPages - 1) {
        emit(PageViewNavigationState(state.pageViewNumber + 1));
      }
      if (navType == NavigatePage.reverse && state.pageViewNumber > 0) {
        emit(PageViewNavigationState(state.pageViewNumber - 1));
      }
      validateNextButtonState(state.pageViewNumber);
    }
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
        nextButtonEnable = _propertyName.isNotEmpty &&
            _price != null &&
            _rentPeriod != MinimumRentPeriod.invalid &&
            _australiaState != AustraliaStates.invalid &&
            _address.isNotEmpty &&
            _suburb.isNotEmpty &&
            _postalCode != null;
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
      case 5: // preview
      showRightChevron = false;
      nextButtonEnable = true;
      label = ButtonLabel.submit;
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

  void _submitPropertyDetails() async {
    // show loading
    emit(StartSubmitPropertyDetails(state.pageViewNumber));

    // other steps
    // upload photos
    final String folder = _generateFolderName();
    List<String> uploadedPhotos = [];
    for (String path in photos) {
      // compress file
      File file5mb = await _photoService.createThumbnail(File(path),
          targetBytes: 5*1024*1024); // target 5MB

      await _storageService.files.uploadFile(
        folder: folder,
        path: file5mb.path,
        onError: (e) {
          debugPrint('Error $e');
        },
        onComplete: (url) {
          uploadedPhotos.add(url);
        },
      );

      // delete this file
      await file5mb.delete();
    }

    // add this ID into user's list of properties
    try {
      final UserDetail user = await _authenticationService.getCurrentUser();
    final Property property = Property(
        type: _type,
        name: _propertyName,
        price: Price(
          rentPrice: _price!,
          currency: Currency.aud,
        ), description: _description,
        address: AddressDetail(
            suburb: _suburb,
            postcode: _postalCode!,
            state: _australiaState,
            streetName: _address,
            streetNo: _address,
            unitNo: _unitNumber
        ), additionalDetail: AdditionalDetail(
        bedrooms: _bedrooms,
        bathrooms: _bathrooms,
        parkings: _parking,
        additional: _features.map((e) => e.name).toList()
    ), photos: uploadedPhotos,
        minimumRentPeriod: _rentPeriod,
        location: const GeoPoint(0.0, 0.0), // TODO convert address into Geopoint
        availableDate: Timestamp.fromDate(_availableDate),
        ownerUid: user.uid);

    final String id = await _storageService.property.addProperty(property);

      _storageService.member.addMemberProperties(user.uid, id);
    } on UserNotFoundException catch (_) {
      // do nothing
    }
    // complete upload
    emit(EndSubmitPropertyDetails(state.pageViewNumber));
  }

  String _generateFolderName() {
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

    return String.fromCharCodes(Iterable.generate(
        18, (_) => chars.codeUnitAt(Random().nextInt(chars.length))));
  }
}
