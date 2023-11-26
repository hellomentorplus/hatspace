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

  // only get day, month, and year at the first time. StartTime need to be updated in UI
  DateTime _inspecitonStartTime = DateTime.now().copyWith(hour: 0, minute: 0);
  int? _duration;

  set inspectionStartTime(DateTime startTime) {
    _inspecitonStartTime = startTime;
    validateBookingInspectionButton();
  }

  DateTime get inspectionStartTime => _inspecitonStartTime;

  set duration(int? duration) {
    _duration = duration;
    validateBookingInspectionButton();
  }

  void updateInspectionDateOnly(
      {required int day, required int month, required int year}) {
    inspectionStartTime =
        _inspecitonStartTime.copyWith(day: day, year: year, month: month);
    validateBookingInspectionButton();
  }

  void updateInspectionStartTime(
      {required int newHour, required int newMinute}) {
    _inspecitonStartTime =
        _inspecitonStartTime.copyWith(hour: newHour, minute: newMinute);
    validateBookingInspectionButton();
  }

  int? get duration => _duration;

  void validateBookingInspectionButton() {
    // TO DO: Add duration to validation
    if (_inspecitonStartTime.hour != 0 || _inspecitonStartTime.minute != 0) {
      if (_duration != null) {
        emit(BookInspectionButtonEnable());
      } else {
        emit(CloseStartTimeRequestMessage());
      }
    }
    if (_inspecitonStartTime.hour == 0 && duration == null) {
      emit(RequestStartTimeSelection());
    }
  }
}
