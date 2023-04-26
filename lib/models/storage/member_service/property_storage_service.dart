import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatspace/data/data.dart';

enum PropAddKeys { bedrooms, bathrooms, parkings, additional }

class PropertyService {
  final FirebaseFirestore _firestore;

  final String propertyCollection = 'properties';

  PropertyService(FirebaseFirestore firestore) : _firestore = firestore;

  Future<Property?> getProperty(String id) async {
    DocumentSnapshot<Map<String, dynamic>> proppertiesRef = await _firestore
        .collection(propertyCollection)
        .doc(id)
        .get(const GetOptions(source: Source.server));

    if (!proppertiesRef.exists) {
      return null;
    }

    final Map<String, dynamic>? data = proppertiesRef.data();
    if (data == null) {
      return null;
    }

    // Get Property additional detail of a property
    AdditionalDetail additionalDetail = getPropertyAdditionalDetials(data);

    // GET Price 
    Map mapPrice = data[Property.propPrice];
    Price price = Price(
      currency: Currency.fromName(mapPrice[Price.currencyKey]),
      rentPrice: (mapPrice[Price.rentPriceKey] as int).toDouble()
    );

    // Get actual property
    Property property = Property(
        id: id,
        type: PropertyTypes.fromName((data[Property.propType])),
        name: data[Property.propName],
        price: price,
        description: data[Property.propDescription],
        address: data[Property.propAddress],
        additionalDetail: additionalDetail,
        photos: List<String>.from([Property.propPhoto]),
        minimumRentPeriod:
            MinimumRentPeriod.fromName(data[Property.propMinimumRentPeriod]));
    return property;
  }

  AdditionalDetail getPropertyAdditionalDetials(Map<String, dynamic> data) {
    Map additional = data[Property.propPropDetails];

    AdditionalDetail additionalDetail = AdditionalDetail(
        bedrooms: additional[PropAddKeys.bedrooms.name],
        bathrooms: additional[PropAddKeys.bathrooms.name],
        parkings: additional[PropAddKeys.parkings.name],
        additional: List<String>.from(additional[PropAddKeys.additional.name]));
    return additionalDetail;
  }

  Future<void> saveProperty(Property property) async {
    await _firestore
        .collection(propertyCollection)
        .doc()
        .set(mapObjectToMap(property));
  }

  Map<String, dynamic> mapObjectToMap(Property property) {
    Map<String, dynamic> mapProp = {
      Property.propAddress: property.address,
      Property.propDescription: property.description,
      Property.propMinimumRentPeriod: property.minimumRentPeriod.text,
      Property.propName: property.name,
      Property.propPhoto: property.photos,
      Property.propPrice: property.price,
      Property.propPropDetails: {
        AdditionalDetail.bathroomKey: property.additionalDetail.bathrooms,
        AdditionalDetail.bedroomKey: property.additionalDetail.bedrooms,
        AdditionalDetail.parkingKey: property.additionalDetail.parkings,
        AdditionalDetail.additionalKey: property.additionalDetail.additional
      },
      Property.propType: property.type.name
    };
    return mapProp;
  }
}
