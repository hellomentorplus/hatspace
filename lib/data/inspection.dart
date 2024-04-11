enum InspectionStatus {
  confirming,
  denied,
  confirmed,
}

class Inspection {
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
}
