enum InspectionStatus {
  confirming,
  denied,
  confirmed,
  
}

class Inspection {
  String? inspectionId;
  String propertyId;
  DateTime startTime;
  DateTime endTime;
  String? message;
  InspectionStatus status;
  DateTime createdDate = DateTime.now();
  String createdBy;
  Inspection({
    required this.propertyId,
    required this.startTime,
    required this.endTime,
    required this.createdBy,
    this.status = InspectionStatus.confirming,
    this.message = ''
  });

  Map<String, dynamic> convertToMap(){
    return{
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
