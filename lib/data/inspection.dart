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
  static const inspectionIdKey = 'inspectionIdKey';
  static const propertyIdKey = 'propertyId';
  static const startTimeKey = 'startTime';
  static const inspectionStatusKey = 'inspectionStatus';
  static const messageKey = 'message';
  static const endTimeKey = 'endTime';
  static const createdByKey = 'createdBy';
  final String? inspectionId;
  final String propertyId;
  final DateTime startTime;
  final DateTime endTime;
  final String? message;
  final InspectionStatus status;
  final DateTime createdDate = DateTime.now();
  final String createdBy;
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



  String getRentingTime() {
    //   '09:00 AM - 10:00 AM - 15 Sep, 2023',
    return '${DateFormat('hh:mm a').format(startTime)} - ${DateFormat('hh:mm a').format(endTime)} - ${DateFormat('d MMM, yyyy ').format(startTime)}';
  }

  static Inspection convertToObject(Map<String, dynamic> data) {
    return Inspection(
        inspectionId: data[inspectionIdKey],
        propertyId: data[propertyIdKey],
        startTime: (data[startTimeKey] as Timestamp).toDate(),
        status: InspectionStatus.fromName(data[inspectionStatusKey]),
        message: data[messageKey],
        endTime: (data[endTimeKey] as Timestamp).toDate(),
        createdBy: data[createdByKey]);
  }
}
