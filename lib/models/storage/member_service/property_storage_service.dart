import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatspace/data/data.dart';

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

  Future<void> saveProperty(Property property) async {
    await _firestore
        .collection(propertyCollection)
        .doc()
        .set(property.convertObjectToMap());
  }

  // // Case1: When database design with mulitple subcolleciton
  // // test_properties/AU/3170/
  // Future<List<Property>?> getAllPropertiesTest() async {
  //   //   QuerySnapshot<Map<String,dynamic>>? propertyList = await _firestore
  //   //   .collection("test_properties")
  //   //   .doc("AU")
  //   //   .collection("3170")
  //   //   .get(const GetOptions(source: Source.server));
  //   //   print(propertyList);
  //   //   if( propertyList.docs.isEmpty){
  //   //     return null;
  //   //   }
  //   //   Iterable<Map<String, dynamic>> list = propertyList.docs.map((doc){
  //   //     return doc.data();
  //   //   }).toList();
  //   //   print(list);

  //   // case2: When database design with using reference
  //   // Should not user referenc
  //   // Reason: => Firebase package (Cloud Firestore ODM) does not have many support for flutter

  //   //     DocumentSnapshot<Map<String,dynamic>>? propertyList = await _firestore
  //   //   .collection("VIC")
  //   //   .doc("3171").get(const GetOptions(source: Source.server));
  //   //   print(propertyList);
  //   //   if( !propertyList.exists){
  //   //     return null;
  //   //   }
  //   //  Map<String, dynamic>? list = propertyList.data();
  //   //  print(list);

  //   //case 3: When databse is designed as same as case 1 design
  //   // using groupCollection
  //   QuerySnapshot<Map<String, dynamic>>? proppertiesRef = await _firestore
  //       .collection("test_properties")
  //       .doc("AU")
  //       .collection('3170')
  //       .where("suburb", isEqualTo: "suburb1")
  //       .get(const GetOptions(source: Source.server));

  //   if (proppertiesRef.docs.isEmpty) {
  //     return null;
  //   }
  //   Iterable<Map<String, dynamic>> list = proppertiesRef.docs.map((doc) {
  //     return doc.data();
  //   }).toList();

  //   // When data is not exits
  //   return null;
  // }
}
