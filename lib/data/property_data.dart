// Property key field match with firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatspace/strings/l10n.dart';

// Field names for firebase firestore
class PropKeys {
  static const type = 'type';
  static const name = 'name';
  static const price = 'price';
  static const currency = 'currency';
  static const description = 'description';
  static const address = 'address';
  static const additionalDetail = 'propertyDetails';
  static const photos = 'photos';
  static const rentPeriod = 'rentPeriod';
  static const surbub = 'surbub';
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
  static const createdAt = 'createAt';
  static const country = 'country';
  static const availableDate = 'availableDate';
}

enum PropertyTypes {
  house,
  apartment,
  invalid;

  static PropertyTypes fromName(String name) {
    return values.firstWhere((element) => element.name == name,
        orElse: () => invalid);
  }
}

enum AustraliaStates {
  //TODO: add more states for upcomming story
  nsw,
  vic,
  qld,
  wa,
  sa,
  tas,
  act,
  nt,
  invalid;

  const AustraliaStates();
  String get stateName {
    switch (this) {
      case nsw:
        return HatSpaceStrings.current.nsw;
      case vic:
        return HatSpaceStrings.current.vic;
      case qld:
        return HatSpaceStrings.current.qld;
      case wa:
        return HatSpaceStrings.current.wa;
      case tas:
        return HatSpaceStrings.current.tas;
      case act:
        return HatSpaceStrings.current.act;
      case nt:
        return HatSpaceStrings.current.nt;
      default:
        return 'Invalid state name';
    }
  }

  static AustraliaStates fromName(String name) =>
      values.firstWhere((element) => element.name == name.toLowerCase(),
          orElse: () => invalid);

  static AustraliaStates getStateCode(String stateName) {
    if (stateName == HatSpaceStrings.current.nsw) {
      return nsw;
    } else if (stateName == HatSpaceStrings.current.vic) {
      return vic;
    } else if (stateName == HatSpaceStrings.current.qld) {
      return qld;
    } else if (stateName == HatSpaceStrings.current.wa) {
      return wa;
    } else if (stateName == HatSpaceStrings.current.tas) {
      return tas;
    } else if (stateName == HatSpaceStrings.current.act) {
      return act;
    } else if (stateName == HatSpaceStrings.current.nt) {
      return nt;
    } else {
      return invalid;
    }
  }
}

enum MinimumRentPeriod {
  //TODO: add more value for upcomming story
  threeMonths,
  sixMonths,
  invalid;

  const MinimumRentPeriod();
  String get rentPeriodName {
    switch (this) {
      case threeMonths:
        return HatSpaceStrings.current.threeMonths;
      case sixMonths:
        return HatSpaceStrings.current.sixMonths;
      // TODO: add more values in next story
      default:
        return 'invalid';
    }
  }

  static MinimumRentPeriod getPeriod(String period) {
    if (period == HatSpaceStrings.current.threeMonths) {
      return threeMonths;
    } else if (period == HatSpaceStrings.current.sixMonths) {
      return sixMonths;
    } else {
      return invalid;
    }
  }

  static MinimumRentPeriod fromName(String name) => values
      .firstWhere((element) => element.name == name, orElse: () => invalid);
}

enum Currency {
  aud;

  static Currency fromName(String name) =>
      values.firstWhere((element) => element.name == name.toLowerCase(),
          orElse: () => aud);
}

class Price {
  final Currency currency;
  final double rentPrice;
  Price({this.currency = Currency.aud, this.rentPrice = 0.0});

  static Price convertMapToObject(Map<String, dynamic> map) {
    return Price(
        currency: Currency.fromName(map[PropKeys.currency]),
        rentPrice: (map[PropKeys.price] as double).toDouble());
  }
}

enum CountryCode {
  au,
  us;

  static CountryCode fromName(String name) =>
      values.firstWhere((element) => element.name == name.toLowerCase(),
          orElse: () => au);
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
    required this.streetName, required this.streetNo, required this.postcode, required this.suburb, required this.state, this.unitNo = '',
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
  final CountryCode country;
  final GeoPoint location;
  final Timestamp createdTime;
  final Timestamp availableDate;
  Property(
      {required this.type, required this.name, required this.price, required this.description, required this.address, required this.additionalDetail, required this.photos, required this.minimumRentPeriod, required this.location, required this.availableDate, this.id,
      CountryCode? country,
      Timestamp? createdTime})
      : country = country ?? CountryCode.au,
        createdTime = createdTime ?? Timestamp.now();
  // convertObjectToMap is used to upload Map type to firestore
  Map<String, dynamic> convertObjectToMap() {
    Map<String, dynamic> mapProp = {
      PropKeys.name: name,
      PropKeys.price: {
        PropKeys.currency: price.currency.name,
        PropKeys.price: price.rentPrice
      },
      PropKeys.rentPeriod: minimumRentPeriod.name,
      PropKeys.description: description,
      PropKeys.address: address.convertAddressToMap(),
      PropKeys.additionalDetail: {
        PropKeys.bathroom: additionalDetail.bathrooms,
        PropKeys.bedroom: additionalDetail.bedrooms,
        PropKeys.parking: additionalDetail.parkings,
        PropKeys.additional: additionalDetail.additional
      },
      PropKeys.availableDate: availableDate,
      PropKeys.photos: photos,
      PropKeys.createdAt: createdTime,
      PropKeys.location: location,
      PropKeys.type: type.name,
      PropKeys.country: country.name.toUpperCase(),
      'filter_by_postcode': address.postcode,
      'filter_by_surbub': address.suburb,
      'filter_by_state': address.state.name
    };
    return mapProp;
  }

  static Property convertMapToObject(Map<String, dynamic> map) {
    return Property(
        type: PropertyTypes.fromName(map[PropKeys.type]),
        name: map[PropKeys.name],
        price: Price.convertMapToObject(map[PropKeys.price]),
        description: map[PropKeys.description],
        address: AddressDetail.convertMapToObject(map[PropKeys.address]),
        additionalDetail:
            AdditionalDetail.convertMapToObject(map[PropKeys.additionalDetail]),
        photos: List<String>.from(map[PropKeys.photos]),
        minimumRentPeriod: MinimumRentPeriod.fromName(map[PropKeys.rentPeriod]),
        country: CountryCode.fromName(map[PropKeys.country]),
        location: map[PropKeys.location],
        createdTime: map[PropKeys.createdAt],
        availableDate: map[PropKeys.availableDate]);
  }
}
