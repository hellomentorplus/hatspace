part of 'property_detail_cubit.dart';

/// states
abstract class PropertyDetailState extends Equatable {
  const PropertyDetailState();
}

class PropertyDetailInitial extends PropertyDetailState {
  @override
  List<Object> get props => [];
}

class PropertyNotFound extends PropertyDetailState {
  @override
  List<Object?> get props => [];
}

class PropertyDetailLoaded extends PropertyDetailState {
  final List<String> photos;
  final String type;
  final String name;
  final String state;
  final int bedrooms;
  final int bathrooms;
  final int carspaces;
  final String description;
  final String fullAddress;
  final List<Feature> features;
  final String ownerName;
  final String? ownerAvatar;
  final bool isOwned;
  final DateTime availableDate;
  final Price price;

  const PropertyDetailLoaded(
      {required this.photos,
      required this.type,
      required this.name,
      required this.state,
      required this.bedrooms,
      required this.bathrooms,
      required this.carspaces,
      required this.description,
      required this.fullAddress,
      required this.features,
      required this.ownerAvatar,
      required this.ownerName,
      required this.isOwned,
      required this.availableDate,
      required this.price});

  @override
  List<Object?> get props => [
        ownerName,
        ownerAvatar,
        ...photos,
        type,
        name,
        state,
        bedrooms,
        bathrooms,
        carspaces,
        description,
        fullAddress,
        isOwned,
        availableDate,
        price
      ];
}