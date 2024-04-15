// Property key field match with firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/gen/assets.gen.dart';

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
  static const owner = 'owner';
  static const inspectionList = 'inspectionList';
}

enum PropertyTypes {
  house,
  apartment;

  const PropertyTypes();

  String getIconPath() {
    switch (this) {
      case house:
        return Assets.images.house;
      case apartment:
        return Assets.images.apartment;
      default:
    }
    return 'No image path';
  }

  String get displayName {
    switch (this) {
      case PropertyTypes.house:
        return HatSpaceStrings.current.house;
      case PropertyTypes.apartment:
        return HatSpaceStrings.current.apartment;
    }
  }

  static PropertyTypes fromName(String name) => values.firstWhere(
        (element) => element.name == name,
        orElse: () => PropertyTypes.house,
      );
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
  String get displayName => HatSpaceStrings.current.australiaState(this);

  static AustraliaStates fromName(String name) =>
      values.firstWhere((element) => element.name == name.toLowerCase(),
          orElse: () => invalid);
}

enum MinimumRentPeriod {
  //TODO: add more value for upcomming story
  oneMonth(1),
  threeMonths(3),
  sixMonths(6),
  nineMonths(9),
  twelveMonths(12),
  eighteenMonths(18),
  twentyFourMonths(24),
  thirtySixMonths(36),
  invalid(0);

  const MinimumRentPeriod(this.months);
  final int months;
  String get displayName => HatSpaceStrings.current.rentPeriod(months);

  static MinimumRentPeriod fromMonthsValue(int months) => values
      .firstWhere((element) => element.months == months, orElse: () => invalid);
}

enum Currency {
  aud(r'$');

  static Currency fromName(String name) =>
      values.firstWhere((element) => element.name == name.toLowerCase(),
          orElse: () => aud);

  final String symbol;
  const Currency(this.symbol);
}

class Price {
  final Currency currency;
  final double rentPrice;
  Price({this.currency = Currency.aud, this.rentPrice = 0.0});

  static Price convertMapToObject(Map<String, dynamic> map) {
    return Price(
        currency: Currency.fromName(map[PropKeys.currency]),
        rentPrice: double.tryParse('${map[PropKeys.price]}') ?? 0.0);
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
  final String postcode;
  final String suburb;
  final AustraliaStates state;
  const AddressDetail({
    required this.streetName,
    required this.streetNo,
    required this.postcode,
    required this.suburb,
    required this.state,
    this.unitNo = '',
  });
  Map<String, dynamic> convertAddressToMap() {
    Map<String, dynamic> mapAddress = {
      PropKeys.unitNo: unitNo,
      PropKeys.streetNo: streetNo,
      PropKeys.streetName: streetName,
      PropKeys.postcode: postcode,
      PropKeys.state: state.name,
      PropKeys.surbub: suburb,
    };
    return mapAddress;
  }

  static AddressDetail convertMapToObject(Map<String, dynamic> map) {
    return AddressDetail(
        unitNo: map[PropKeys.unitNo],
        streetName: map[PropKeys.streetName],
        streetNo: map[PropKeys.streetNo],
        postcode: map[PropKeys.postcode],
        suburb: map[PropKeys.surbub],
        state: AustraliaStates.fromName(map[PropKeys.state]));
  }

  String get fullAddress =>
      '${unitNo?.isNotEmpty == true ? '$unitNo, ' : ''}$streetName, $suburb, ${state.displayName} $postcode';
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
  final String ownerUid;
  final List<String> inspectionList;
  Property({
    required this.type,
    required this.name,
    required this.price,
    required this.description,
    required this.address,
    required this.additionalDetail,
    required this.photos,
    required this.minimumRentPeriod,
    required this.location,
    required this.availableDate,
    required this.ownerUid,
    List<String>? inspectionList,
    this.id,
    CountryCode? country,
    Timestamp? createdTime,
  })  : country = country ?? CountryCode.au,
        createdTime = createdTime ?? Timestamp.now(),
        inspectionList = inspectionList ?? const [];
  // convertObjectToMap is used to upload Map type to firestore
  Map<String, dynamic> convertObjectToMap() {
    Map<String, dynamic> mapProp = {
      PropKeys.name: name,
      PropKeys.price: {
        PropKeys.currency: price.currency.name,
        PropKeys.price: price.rentPrice
      },
      PropKeys.rentPeriod: minimumRentPeriod.months,
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
      'filter_by_state': address.state.name,
      PropKeys.owner: ownerUid,
      PropKeys.inspectionList: inspectionList
    };
    return mapProp;
  }

  static Property convertMapToObject(String id, Map<String, dynamic> map) {
    List<String> inspectionList = [];
    if (map[PropKeys.inspectionList] != null) {
      inspectionList = List<String>.from(map[PropKeys.inspectionList]);
    }
    return Property(
        id: id,
        type: PropertyTypes.fromName(map[PropKeys.type]),
        name: map[PropKeys.name],
        price: Price.convertMapToObject(map[PropKeys.price]),
        description: map[PropKeys.description],
        address: AddressDetail.convertMapToObject(map[PropKeys.address]),
        additionalDetail:
            AdditionalDetail.convertMapToObject(map[PropKeys.additionalDetail]),
        photos: List<String>.from(map[PropKeys.photos]),
        minimumRentPeriod:
            MinimumRentPeriod.fromMonthsValue(map[PropKeys.rentPeriod]),
        country: CountryCode.fromName(map[PropKeys.country]),
        location: map[PropKeys.location],
        createdTime: map[PropKeys.createdAt],
        availableDate: map[PropKeys.availableDate],
        ownerUid: map[PropKeys.owner],
        inspectionList: inspectionList);
  }
}

enum Feature {
  fridge,
  washingMachine,
  swimmingPool,
  airConditioners,
  electricStove,
  tv,
  wifi,
  securityCameras,
  kitchen,
  portableFans;

  String get displayName {
    switch (this) {
      case Feature.fridge:
        return HatSpaceStrings.current.fridge;
      case Feature.swimmingPool:
        return HatSpaceStrings.current.swimmingPool;
      case Feature.washingMachine:
        return HatSpaceStrings.current.washingMachine;
      case Feature.airConditioners:
        return HatSpaceStrings.current.airConditioners;
      case Feature.electricStove:
        return HatSpaceStrings.current.electricStove;
      case Feature.tv:
        return HatSpaceStrings.current.tv;
      case Feature.wifi:
        return HatSpaceStrings.current.wifi;
      case Feature.securityCameras:
        return HatSpaceStrings.current.securityCameras;
      case Feature.kitchen:
        return HatSpaceStrings.current.kitchen;
      case Feature.portableFans:
        return HatSpaceStrings.current.portableFans;
    }
  }

  String get iconSvgPath {
    switch (this) {
      case Feature.fridge:
        return Assets.icons.fridge;
      case Feature.swimmingPool:
        return Assets.icons.swimmingPool;
      case Feature.washingMachine:
        return Assets.icons.washingMachine;
      case Feature.airConditioners:
        return Assets.icons.airConditioners;
      case Feature.electricStove:
        return Assets.icons.electricStove;
      case Feature.tv:
        return Assets.icons.tv;
      case Feature.wifi:
        return Assets.icons.wifi;
      case Feature.securityCameras:
        return Assets.icons.securityCameras;
      case Feature.kitchen:
        return Assets.icons.kitchen;
      case Feature.portableFans:
        return Assets.icons.portableFans;
    }
  }
}
