class InspectionKey {
  static const _inspectionIdKey = 'inspection_id';
  static const _message = 'message';
  static const _startTime = 'start_time';
  static const _endTime = 'end_time';
  static const _propertyId = 'property_id';
  static const _createdBy = 'created_by';
  static const _createdDate = 'created_date';
  static const _status = 'status';
}

enum InspectionStatus {
  confirming,
  confirmed, 
  denied,
}

class Inspection {
  final String? inspectionId;
  final String? message;
  final DateTime startTime;
  final DateTime endTime;
  final String propertyId;
  final String createdBy;
  final DateTime createdDate = DateTime.now();
  final InspectionStatus inspectionStatus;

  Inspection(
      {required this.startTime,
      required this.endTime,
      required this.propertyId,
      required this.createdBy,
      required this.inspectionStatus,
      this.message,
      this.inspectionId, 
      });

  Map<String, dynamic> convertToMap() {
    Map<String, dynamic> mapInspection = {
      InspectionKey._inspectionIdKey: inspectionId,
      InspectionKey._message: message,
      InspectionKey._startTime: startTime,
      InspectionKey._endTime: endTime,
      InspectionKey._createdDate: createdDate,
      InspectionKey._createdBy: createdBy,
      InspectionKey._propertyId: propertyId,
      InspectionKey._status: inspectionStatus.name
    };
    return mapInspection;
  }
}
