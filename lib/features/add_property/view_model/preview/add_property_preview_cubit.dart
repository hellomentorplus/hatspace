import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';

part 'add_property_preview_state.dart';

class AddPropertyPreviewCubit extends Cubit<AddPropertyPreviewState> {
  final PropertyTypes type;
  final DateTime availableDate;
  final AustraliaStates ausState;
  final MinimumRentPeriod rentPeriod;
  final String propertyName;
  final double? price;
  final String suburb;
  final int? postalCode;
  final String unitNumber;
  final String address;
  final String description;
  final int bedrooms;
  final int bathrooms;
  final int parking;
  final List<Feature> features;
  final List<String> photos;
  final AuthenticationService _authenticationService =
      HsSingleton.singleton.get<AuthenticationService>();

  AddPropertyPreviewCubit({
    required this.type,
    required this.availableDate,
    required this.ausState,
    required this.rentPeriod,
    required this.propertyName,
    required this.price,
    required this.suburb,
    required this.postalCode,
    required this.unitNumber,
    required this.address,
    required this.description,
    required this.bedrooms,
    required this.bathrooms,
    required this.parking,
    required this.features,
    required this.photos,
  }) : super(AddPropertyPreviewInitial()) {
    _validateDataPreview();
  }

  void _validateDataPreview() async {
    // last data validation
    if (price == null) {
      // data not ready
      return;
    }
    if (postalCode == null) {
      // data not ready
      return;
    }

    try {
      final UserDetail userDetail =
          await _authenticationService.getCurrentUser();

      // last page, update state to load data onto preview
      emit(AddPropertyPreviewReady(
          type: type,
          availableDate: availableDate,
          ausState: ausState,
          rentPeriod: rentPeriod,
          propertyName: propertyName,
          price: price!,
          suburb: suburb,
          postalCode: postalCode!,
          unitNumber: unitNumber,
          address: address,
          description: description,
          bedrooms: bedrooms,
          bathrooms: bathrooms,
          parking: parking,
          features: features,
          photos: photos,
          userDisplayName: userDetail.displayName,
          userPhoto: userDetail.avatar));
    } on UserNotFoundException catch (_) {
      // do nothing
    }
  }
}
