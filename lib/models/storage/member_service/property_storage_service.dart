import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatspace/data/property_data.dart';

class PropertyService {
  final FirebaseFirestore _firestore;
  final String propertyCollection = 'properties';

  PropertyService(FirebaseFirestore firestore) : _firestore = firestore;

  Future<Property?> getProperty(String id) async {
    DocumentSnapshot<Map<String, dynamic>> propertyRef = await _firestore
        .collection(propertyCollection)
        .doc(id)
        .get(const GetOptions(source: Source.server));

    if (!propertyRef.exists) {
      return null;
    }

    final Map<String, dynamic>? data = propertyRef.data();
    // When data is not exits
    if (data == null) {
      return null;
    } else {
      return Property.convertMapToObject(id, data);
    }
  }

  Future<List<Property>?> getAllProperties() async {
    // TODO: To be confirm with PO about limitQuery
    //
    const limitQuery = 20;
    QuerySnapshot<Map<String, dynamic>>? proppertiesRef = await _firestore
        .collection(propertyCollection)
        .limit(limitQuery)
        .get(const GetOptions(source: Source.server));
    if (proppertiesRef.docs.isEmpty) {
      return null;
    }
    List<Property> propertiesList = proppertiesRef.docs.map((doc) {
      return Property.convertMapToObject(doc.id, doc.data());
    }).toList();
    return propertiesList;
  }

  Future<String> addProperty(Property property) async {
    DocumentReference documentReference =
        _firestore.collection(propertyCollection).doc();

    await documentReference.set(property.convertObjectToMap());

    return documentReference.id;
  }

  Future addInspectionToInspectionList(
      String propertyId, String inspectionId) async {
    await _firestore.collection(propertyCollection).doc(propertyId).update({
      PropKeys.inspectionList: FieldValue.arrayUnion([inspectionId])
    });
  }
}
