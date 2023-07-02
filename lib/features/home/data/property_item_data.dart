import 'package:equatable/equatable.dart';
import 'package:hatspace/data/property_data.dart';
import 'package:intl/intl.dart';

class PropertyItemData extends Equatable {
  final String? id;
  final List<String> photos;
  final String price;
  final String name;
  final PropertyTypes type;
  final int bedrooms;
  final int bathrooms;
  final int parkings;
  final int todayViews;
  final String availableDate;
  final String ownerName;
  final String ownerAvatar;
  final bool isFavorited;

  const PropertyItemData(
      {required this.id,
      required this.photos,
      required this.price,
      required this.name,
      required this.type,
      required this.bedrooms,
      required this.bathrooms,
      required this.parkings,
      required this.todayViews,
      required this.availableDate,
      required this.ownerName,
      required this.ownerAvatar,
      required this.isFavorited});

  factory PropertyItemData.fromModel(Property property, User user) => PropertyItemData(
    id: property.id,
    photos: property.photos,
    price: '${property.price.currency.symbol}${property.price.rentPrice}',
    name: property.name,
    type: property.type,
    bedrooms: property.additionalDetail.bedrooms,
    bathrooms: property.additionalDetail.bathrooms,
    parkings: property.additionalDetail.parkings,
    todayViews: 0,
    availableDate: DateFormat('MM/dd/yy').format(
              DateTime.fromMillisecondsSinceEpoch(
                  property.availableDate.millisecondsSinceEpoch)),
    ownerName: user.name,
    ownerAvatar: user.avatar,
    isFavorited: false
  );

  @override
  List<Object?> get props => [
        id,
        photos,
        price,
        name,
        type,
        bedrooms,
        bathrooms,
        parkings,
        todayViews,
        availableDate,
        ownerName,
        ownerAvatar,
        isFavorited
      ];
}
