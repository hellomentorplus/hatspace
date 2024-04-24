import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatspace/data/inspection.dart';

class InpsectionService {
  final FirebaseFirestore _firestore;
  final String inspectionCollection = 'inspections';

  InpsectionService(FirebaseFirestore firestore) : _firestore = firestore;

  Future<String> addInspection(Inspection inspection) async {
    DocumentReference documentReference =
        _firestore.collection(inspectionCollection).doc();
    await documentReference.set(inspection.convertToMap());
    return documentReference.id;
  }

  Future<Inspection?> getInspectionById(String inspectionId) async {
    DocumentSnapshot<Map<String, dynamic>> inspectionRef = await _firestore
        .collection(inspectionCollection)
        .doc(inspectionId)
        .get(const GetOptions(source: Source.server));
    if (!inspectionRef.exists) {
      return null;
    }
    final Map<String, dynamic>? data = inspectionRef.data();
    // When data is not exits
    if (data == null) {
      return null;
    } 
    final Inspection inspection = Inspection.convertToObject(data);
    return inspection;
  }
}
