import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatspace/data/data.dart';

enum PropKeys {
  id,
  type,
  name,
  price,
  description,
  address,
  propertyDetails,
  photos,
  minimumRentPeriod;
  static PropKeys fromName(String name) =>
      values.firstWhere((element) => element.name == name);
}

enum PropAddKeys { bedrooms, bathrooms, parkings, additional }

class PropertyService {
  final FirebaseFirestore _firestore;

  final String propertyCollection = 'properties';

  PropertyService(FirebaseFirestore firestore) : _firestore = firestore;

  Future<Property?> getProperties(String id) async {
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

    // Get actual property
    Property property = Property(
        id: id,
        type: PropertyTypes.fromName((data[PropKeys.type.name])),
        name: data[PropKeys.name.name],
        price: (data[PropKeys.price.name] as int).toDouble(),
        description: data[PropKeys.description.name],
        address: data[PropKeys.address.name],
        additionalDetail: additionalDetail,
        photos: List<String>.from([PropKeys.photos.name]),
        minimumRentPeriod:
            MinimumRentPeriod.fromName(data[PropKeys.minimumRentPeriod.name]));
    return property;
  }

  AdditionalDetail getPropertyAdditionalDetials(Map<String, dynamic> data) {
    Map additional = data[PropKeys.propertyDetails.name];

    AdditionalDetail additionalDetail = AdditionalDetail(
        bedrooms: additional[PropAddKeys.bedrooms.name],
        bathrooms: additional[PropAddKeys.bathrooms.name],
        parkings: additional[PropAddKeys.parkings.name],
        additional: List<String>.from(additional[PropAddKeys.additional.name]));

    return additionalDetail;
  }
}
