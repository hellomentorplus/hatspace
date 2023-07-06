import 'package:equatable/equatable.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/property_data.dart';

class PropertyItemData extends Equatable {
  final String id;
  final List<String> photos;
  final double price;
  final Currency currency;
  final String name;
  final PropertyTypes type;
  final String state;
  final int numberOfBedrooms;
  final int numberOfBathrooms;
  final int numberOfParkings;
  final int numberOfViewsToday;
  final DateTime availableDate;
  final String? ownerName;
  final String? ownerAvatar;
  final bool isFavorited;

  const PropertyItemData(
      {required this.id,
      required this.photos,
      required this.price,
      required this.name,
      required this.type,
      required this.numberOfBedrooms,
      required this.numberOfBathrooms,
      required this.numberOfParkings,
      required this.numberOfViewsToday,
      required this.availableDate,
      required this.isFavorited,
      required this.currency,
      required this.state,
      this.ownerName,
      this.ownerAvatar});

  factory PropertyItemData.fromModels(Property property, UserDetail user) =>
      PropertyItemData(
          id: property.id ?? 'mock-id',

          /// TODO : Update this after Property class was updated with non-nullable id
          photos: property.photos,
          price: property.price.rentPrice,
          name: property.name,
          type: property.type,
          numberOfBedrooms: property.additionalDetail.bedrooms,
          numberOfBathrooms: property.additionalDetail.bathrooms,
          numberOfParkings: property.additionalDetail.parkings,
          numberOfViewsToday: 0,
          availableDate: DateTime.fromMillisecondsSinceEpoch(
              property.availableDate.millisecondsSinceEpoch),
          ownerName: user.displayName,
          ownerAvatar: user.avatar,
          isFavorited: false,
          currency: property.price.currency,
          state: property.address.state.displayName);

  @override
  List<Object?> get props => [
        id,
        ...photos,
        price,
        name,
        type,
        numberOfBedrooms,
        numberOfBathrooms,
        numberOfParkings,
        numberOfViewsToday,
        availableDate,
        ownerName,
        ownerAvatar,
        isFavorited,
        currency,
        state
      ];
}
