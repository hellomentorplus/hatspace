import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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

  String getRentingTime() {
    //   '09:00 AM - 10:00 AM - 15 Sep, 2023',
    return '${DateFormat('hh:mm a').format(startTime)} - ${DateFormat('hh:mm a').format(endTime)} - ${DateFormat('d MMM, yyyy ').format(startTime)}';
  }
}
