import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/data/inspection.dart';
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

  StartTime? _startTime;
  // DateTime? _inspectionDate;
  int? _duration;

  set startTime(StartTime? startTime) {
    _startTime = startTime;
    validateBookingInspectionButton();
  }

  StartTime? get startTime => _startTime;

  set duration(int? duration) {
    _duration = duration;
    validateBookingInspectionButton();
  }

  int? get duration => _duration;

  void validateBookingInspectionButton() {
    // TO DO: Add duration to validation
    if (_startTime != null) {
      if (_duration != null) {
        emit(BookInspectionButtonEnable());
      } else {
        emit(CloseStartTimeRequestMessage());
      }
    }
    if (_startTime == null && duration == null) {
      emit(RequestStartTimeSelection());
    }
  }
}
