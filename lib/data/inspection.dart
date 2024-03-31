import 'package:cloud_firestore/cloud_firestore.dart';

enum InspectionStatus {
  confirming,
  denied,
  confirmed,
  empty;

  const InspectionStatus();
  static InspectionStatus fromName(String name) => values.firstWhere(
        (element) => element.name == name,
        orElse: () => InspectionStatus.empty,
      );
}

class Inspection {
  String? inspectionId;
  String propertyId;
  DateTime startTime;
  DateTime endTime;
  String message;
  InspectionStatus status;
  DateTime createdDate = DateTime.now();
  String createdBy;
  Inspection(
      {required this.propertyId,
      required this.startTime,
      required this.endTime,
      required this.createdBy,
      this.status = InspectionStatus.confirming,
      this.message = '',
      this.inspectionId});

  Map<String, dynamic> convertToMap() {
    return {
      'propertyId': propertyId,
      'startTime': startTime,
      'endTime': endTime,
      'message': message,
      'inspectionStatus': status.name,
      'createdDate': createdDate,
      'createdBy': createdBy
    };
  }

  Inspection convertToObject(Map<String, dynamic> data) {
    return Inspection(
        propertyId: data['propertyId'],
        startTime: (data['startTime'] as Timestamp).toDate(),
        status: InspectionStatus.fromName(data['inspectionStatus']),
        message: data['message'],
        endTime: (data['endTime'] as Timestamp).toDate(),
        createdBy: data['createdBy']);
  }
}
