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
}
