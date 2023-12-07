import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatspace/data/inspection.dart';

class InspectionService {
  final FirebaseFirestore _firestore;
  final String inspectionService = 'inspections';

  InspectionService(FirebaseFirestore firestore) : _firestore = firestore;

  Future<String> addInspection(Inspection inspection) async {
    // Create inspection in inspection Collection
    DocumentReference documentReference =
        _firestore.collection(inspectionService).doc();
    await documentReference.set(inspection.convertToMap());
    // add inpection to it's property
    return documentReference.id;
  }
}
