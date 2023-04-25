import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatspace/data/data.dart';

enum PropertyKeys {
  id,
  type,
  name,
  price,
  description,
  address,
  propertyDetails,
  photos,
  minimumRentPeriod;

  static PropertyKeys fromName(String name) =>
      values.firstWhere((element) => element.name == name);
}

enum PropertyAdditionalKeys { bedrooms, bathrooms, parkings, additional }

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
        type: PropertyTypes.fromName((data[PropertyKeys.type.name])),
        name: data[PropertyKeys.name.name],
        price: (data[PropertyKeys.price.name] as int).toDouble(),
        description: data[PropertyKeys.description.name],
        address: data[PropertyKeys.address.name],
        additionalDetail: additionalDetail,
        photos: List<String>.from([PropertyKeys.photos.name]),
        minimumRentPeriod: MinimumRentPeriod.fromName(
            data[PropertyKeys.minimumRentPeriod.name]));
    return property;
  }

  AdditionalDetail getPropertyAdditionalDetials(Map<String, dynamic> data) {
    Map additional = data[PropertyKeys.propertyDetails.name];

    AdditionalDetail additionalDetail = AdditionalDetail(
        bedrooms: additional[PropertyAdditionalKeys.bedrooms.name],
        bathrooms: additional[PropertyAdditionalKeys.bathrooms.name],
        parkings: additional[PropertyAdditionalKeys.parkings.name],
        additional: List<String>.from(additional[PropertyAdditionalKeys.additional.name]));

    return additionalDetail;
  }
}
