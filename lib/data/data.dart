import 'dart:ffi';

import 'package:flutter/material.dart';

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
  static AustraliaStates fromStateNameToEnum(String stateName) => values.firstWhere((element) {
    return element.stateName == stateName;
  });
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
  static Currency fromName (String name)=> 
  values.firstWhere((element) => element.name == name);
}

class Price {
  final Currency currency;
  final double rentPrice;
  static const currencyKey = "currency";
  static const rentPriceKey = "rentPrice";
  Price({
    this.currency = Currency.AUD,
    this.rentPrice = 0.0
  });
}

class AdditionalDetail {
  final int bedrooms;
  final int bathrooms;
  final int parkings;
  final List<String> additional;

  static const bedroomKey = "bedrooms";
  static const bathroomKey = "bathrooms";
  static const parkingKey = "parkings";
  static const additionalKey = "additional";
  const AdditionalDetail(
      {
         this.bedrooms = 0,
          this.bathrooms = 0,
       this.parkings = 0,
       this.additional = const []
       });
}


class Property {
  final String? id;
  final List<PropertyTypes> listType;
  final String name;
  final Price price;
  final String description;
  final String address;
  final AdditionalDetail additionalDetail;
  final List<String> photos;
  final MinimumRentPeriod minimumRentPeriod;
  static const propId = "id";
static const propType = "type";
static const propName = "name";
static const propPrice = "price";
static const propDescription = "description";
static const propAddress = "address";
static const propPropDetails = "propertyDetails";
static const propPhoto = 'photos';
static const propMinimumRentPeriod="minimumRentPeriod";
  const Property(
      { this.id,
      required this.listType,
      required this.name,
      required this.price,
      required this.description,
      required this.address,
      required this.additionalDetail,
      required this.photos,
      required this.minimumRentPeriod});
  
  } 

enum Roles {
  tenant,
  homeowner;

  // throws IterableElementError.noElement
  static Roles fromName(String name) =>
      values.firstWhere((element) => element.name == name);
}
