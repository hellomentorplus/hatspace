import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetail {
  final String uid;
  final String? phone;
  final String? email;

  UserDetail({required this.uid, this.phone, this.email});
}

enum PropertyTypes {
  house,
  apartment;

  static PropertyTypes fromName(String name) =>
      values.firstWhere((element) => element.name == name);
}

enum AustraliaStates {
  NSW('New South Wales'),
  VIC('Victoria'),
  QLD('Queensland'),
  WA('Western Australia'),
  SA('South Australia'),
  TAS("Tasmania"),
  ACT("Australian Capital Territory"),
  NT('Northern Territory');

  final String stateName;
  const AustraliaStates(this.stateName);
  static AustraliaStates fromStateNameToEnum(String stateName) =>
      values.firstWhere((element) {
        return element.stateName == stateName;
      });
  static AustraliaStates fromName(String stateName) =>
      values.firstWhere((element) => element.name == stateName);
}

enum MinimumRentPeriod {
  //TODO: waiting for PO's confirmaton
  threeMonths('3 Months'),
  sixMonths('6 Months');

  final String text;
  const MinimumRentPeriod(this.text);
  static MinimumRentPeriod fromName(String name) =>
      values.firstWhere((element) {
        return element.text == name;
      });
}

enum Currency {
  AUD;

  static Currency fromName(String name) =>
      values.firstWhere((element) => element.name == name);
}

class Price {
  final Currency currency;
  final double rentPrice;
  Price({this.currency = Currency.AUD, this.rentPrice = 0.0});

  static Price convertMapToObject(Map<String, dynamic> map) {
    return Price(
        currency: Currency.fromName(map[PropKeys.currency]),
        rentPrice: (map[PropKeys.price] as double).toDouble());
  }
}

enum CountryCode {
  AU,
  US;

  static CountryCode fromName(String name) =>
      values.firstWhere((element) => element.name == name);
}

enum Roles {
  tenant,
  homeowner;

  // throws IterableElementError.noElement
  static Roles fromName(String name) =>
      values.firstWhere((element) => element.name == name);
}

class PropKeys {
  static const type = "type";
  static const name = "name";
  static const price = "price";
  static const currency = 'currency';
  static const desciption = "description";
  static const address = "address";
  static const additionalDetail = "propertyDetails";
  static const photos = 'photos';
  static const rentPeriod = "rentPeriod";
  static const surbub = "surbub";
  static const bedroom = 'bedrooms';
  static const bathroom = 'bathrooms';
  static const parking = 'parkings';
  static const additional = 'additionals';
  static const unitNo = 'unitNo';
  static const streetName = 'streetName';
  static const streetNo = 'streetNo';
  static const state = 'state';
  static const postcode = 'postcode';
  static const location = 'location';
  static const createdAt = "createAt";
  static const country = "country";
}

class AdditionalDetail {
  final int bedrooms;
  final int bathrooms;
  final int parkings;
  final List<String> additional;
  const AdditionalDetail(
      {this.bedrooms = 0,
      this.bathrooms = 0,
      this.parkings = 0,
      this.additional = const []});

  static AdditionalDetail convertMapToObject(Map<String, dynamic> map) {
    return AdditionalDetail(
        bedrooms: map[PropKeys.bedroom],
        bathrooms: map[PropKeys.bathroom],
        parkings: map[PropKeys.parking],
        additional: List<String>.from(map[PropKeys.additional]));
  }
}

class AddressDetail {
  final String? unitNo;
  final String streetName;
  final String streetNo;
  final int postcode;
  final String suburb;
  final AustraliaStates state;
  const AddressDetail({
    this.unitNo = "",
    required this.streetName,
    required this.streetNo,
    required this.postcode,
    required this.suburb,
    required this.state,
  });
  Map<String, dynamic> convertAddressToMap() {
    Map<String, dynamic> mapAddress = {
      PropKeys.unitNo: unitNo,
      PropKeys.streetNo: streetNo,
      PropKeys.streetName: streetName,
      PropKeys.postcode: postcode,
      PropKeys.state: state.name,
      PropKeys.surbub: suburb
    };
    return mapAddress;
  }

  static AddressDetail convertMapToObject(Map<String, dynamic> map) {
    return AddressDetail(
        unitNo: map[PropKeys.streetName],
        streetName: map[PropKeys.streetName],
        streetNo: map[PropKeys.streetNo],
        postcode: map[PropKeys.postcode],
        suburb: map[PropKeys.surbub],
        state: AustraliaStates.fromName(map[PropKeys.state]));
  }
}

class Property {
  final String? id;
  final PropertyTypes type;
  final String name;
  final Price price;
  final String description;
  final AddressDetail address;
  final AdditionalDetail additionalDetail;
  final List<String> photos;
  final MinimumRentPeriod minimumRentPeriod;
  final int surbub;
  final CountryCode country;
  final GeoPoint location;
  final Timestamp createdTime;
  const Property({
    this.id,
    required this.type,
    required this.name,
    required this.price,
    required this.description,
    required this.address,
    required this.additionalDetail,
    required this.photos,
    required this.minimumRentPeriod,
    required this.country,
    required this.surbub,
    required this.location,
    required this.createdTime,
  });
   Map<String, dynamic> convertObjectToMap() {
    Map<String, dynamic> mapProp = {
      PropKeys.name: name,
      PropKeys.price: {
        PropKeys.currency: price.currency.name,
        PropKeys.price: price.rentPrice
      },
      PropKeys.rentPeriod: minimumRentPeriod.text,
      PropKeys.desciption: description,
      PropKeys.address: address.convertAddressToMap(),
      PropKeys.additionalDetail: {
        PropKeys.bathroom: additionalDetail.bathrooms,
        PropKeys.bedroom: additionalDetail.bedrooms,
        PropKeys.parking: additionalDetail.parkings,
        PropKeys.additional: additionalDetail.additional
      },
      PropKeys.photos: photos,
      PropKeys.createdAt: Timestamp.now(),
      PropKeys.location: location,
      PropKeys.type: type.name,
      PropKeys.postcode: address.postcode,
      PropKeys.country: country.name,
      PropKeys.surbub: surbub
    };
    return mapProp;
  }

 static Property convertMapToObject(Map<String, dynamic> map) {
    return Property(
        type: PropertyTypes.fromName(map[PropKeys.type]),
        name: map[PropKeys.name],
        price: Price.convertMapToObject(map[PropKeys.price]),
        description: map[PropKeys.desciption],
        address: AddressDetail.convertMapToObject(map[PropKeys.address]),
        additionalDetail: AdditionalDetail.convertMapToObject(map[PropKeys.additionalDetail]),
        photos: List<String>.from(map[PropKeys.photos]),
        minimumRentPeriod:
            MinimumRentPeriod.fromName(map[PropKeys.rentPeriod]),
        country: CountryCode.fromName(map[PropKeys.country]),
        surbub: map[PropKeys.postcode] as int,
        location: map[PropKeys.location],
        createdTime: map[PropKeys.createdAt]);
  }
}
