import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

part 'add_inspection_booking_state.dart';

class AddInspectionBookingCubit extends Cubit<AddInspectionBookingState> {
  final StorageService storageService;
  final AuthenticationService authenticationService;
  AddInspectionBookingCubit()
      : authenticationService =
            HsSingleton.singleton.get<AuthenticationService>(),
        storageService = HsSingleton.singleton.get<StorageService>(),
        super(AddInspectionBookingInitial());
  void onBookInspection() async {
    try {
      UserDetail user = await authenticationService.getCurrentUser();
      List<Roles> userRole = await storageService.member.getUserRoles(user.uid);
      if (userRole.contains(Roles.tenant)) {
        emit(BookingInspectionSuccess());
      }
      if (userRole.isEmpty) {
        // TODO: HANDLE when user has no roles
      }
    } on UserNotFoundException catch (_) {
      // TODO: Implement when there is no user
    }
  }

  DateTime? _startTime;
  DateTime? _inspectionDate;
  int? _duration;
  //TODO: remove when handle setting startTime, inspection and duration
  //   set startTime(DateTime startTime) {
  //   _startTime = startTime;
  //   validateBookingInspectionButton();
  // }

  // set inspectionDate(DateTime inspectionDate){
  //   _inspectionDate = inspectionDate;
  //   validateBookingInspectionButton();
  // }

  // set duration(int duration){
  //   _duration = duration;
  //   validateBookingInspectionButton();
  // }

  void validateBookingInspectionButton() {
    // Assume startTime and date and duration are entered
    // TODO: remove manually update startTime, inspectionDate and Duration
    _startTime = DateTime.now();
    _inspectionDate = DateTime.now();
    _duration = 15;
    if (_startTime != null && _inspectionDate != null && _duration != null) {
      emit(BookingInspectionButtonEnable());
    }
  }
}
