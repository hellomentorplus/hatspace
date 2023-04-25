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
  NSW,
  VIC,
  QLD,
  WA,
  SA,
  TAS,
  ACT,
  NT;
}


enum MinimumRentPeriod {
  threeMonths('3 Months'),
  sixMonths('6 Months');

  final String period;
  const MinimumRentPeriod(this.period);
  static MinimumRentPeriod fromName(String name) =>
      values.firstWhere((element) {
        return element.period == name;
      });
}

class AdditionalDetail {
  final int bedrooms;
  final int bathrooms;
  final int parkings;
  final List<String> additional;
  const AdditionalDetail(
      {required this.bedrooms,
      required this.bathrooms,
      required this.parkings,
      required this.additional});
}


class Property {
  final String id;
  final PropertyTypes type;
  final String name;
  final double price;
  final String description;
  final String address;
  final AdditionalDetail additionalDetail;
  final List<String> photos;
  final MinimumRentPeriod minimumRentPeriod;
  const Property(
      {required this.id,
      required this.type,
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
