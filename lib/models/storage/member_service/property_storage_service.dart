import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/property_data.dart';

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
    // When data is not exits
    if (data == null) {
      return null;
    } else {
      return Property.convertMapToObject(data);
    }
  }

  Future<List<Property>?> getAllProperties() async {
    const limitQuery = 20;
    QuerySnapshot<Map<String, dynamic>>? proppertiesRef = await _firestore
        .collection(propertyCollection)
        .limit(limitQuery)
        .get(const GetOptions(source: Source.server));
    if (proppertiesRef.docs.isEmpty) {
      return null;
    }
    List<Property> propertiesList = proppertiesRef.docs.map((doc) {
      return Property.convertMapToObject(doc.data());
    }).toList();
    return propertiesList;
  }

  Future<void> addProperty(Property property) async {
    await _firestore
        .collection(propertyCollection)
        .doc()
        .set(property.convertObjectToMap());
  }
}
