part of 'add_property_preview_cubit.dart';

abstract class AddPropertyPreviewState extends Equatable {
  const AddPropertyPreviewState();
}

class AddPropertyPreviewInitial extends AddPropertyPreviewState {
  @override
  List<Object> get props => [];
}

class AddPropertyPreviewReady extends AddPropertyPreviewState {
  final PropertyTypes type;
  final DateTime availableDate;
  final AustraliaStates ausState;
  final MinimumRentPeriod rentPeriod;
  final String propertyName;
  final double price;
  final String suburb;
  final String postalCode;
  final String unitNumber;
  final String address;
  final String description;
  final int bedrooms;
  final int bathrooms;
  final int parking;
  final List<Feature> features;
  final List<String> photos;
  final String? userDisplayName;
  final String? userPhoto;

  const AddPropertyPreviewReady({
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
    required this.userDisplayName,
    required this.userPhoto,
  });

  @override
  List<Object?> get props => [
        type,
        availableDate,
        ausState,
        rentPeriod,
        propertyName,
        price,
        suburb,
        postalCode,
        unitNumber,
        address,
        description,
        bedrooms,
        bathrooms,
        parking,
        ...features,
        ...photos,
        userDisplayName,
        userPhoto
      ];
}
