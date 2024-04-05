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
  void onBookInspection(String propertyId) async {
    try {
      final UserDetail user = await authenticationService.getCurrentUser();
      final List<Roles> userRole =
          await storageService.member.getUserRoles(user.uid);
      final PhoneNumber? phoneNumber =
          await storageService.member.getMemberPhoneNumber(user.uid);
      if (userRole.contains(Roles.tenant)) {
        if (phoneNumber == null) {
          // Always set phoneNo string = null when open modal
          //  _phoneNo = null;
          return emit(ShowUpdateProfileModal());
        }
        saveBookingInspection(propertyId);
      }
      if (userRole.isEmpty) {
        // TODO: HANDLE when user has no roles
      }
    } on UserNotFoundException catch (_) {
      // TODO: Implement when there is no user
    }
  }

  // only get day, month, and year at the first time. StartTime need to be updated in UI
  DateTime? _inspectionStartTime;
  int? _duration;
  bool _isStartTimeSelected = false;
  DateTime? _inspectionEndTime;
  // String? _phoneNo;
  String _description = '';

  set inspectionStartTime(DateTime? startTime) {
    if (_isStartTimeSelected) {
      _inspectionStartTime = _inspectionStartTime?.copyWith(
          hour: startTime!.hour,
          minute: startTime.minute,
          second: startTime.second,
          microsecond: startTime.microsecond);
    } else {
      _inspectionStartTime = startTime;
    }
    _isStartTimeSelected = true;
    emit(CloseStartTimeRequestMessage());
    validateBookingInspectionButton();
  }

  DateTime? get inspectionStartTime => _inspectionStartTime;

  set duration(int? newDuration) {
    _duration = newDuration;
    validateBookingInspectionButton();
  }

  int? get duration => _duration;

  bool get isStartTimeSelected => _isStartTimeSelected;

  DateTime? get inspectionEndTime => _inspectionEndTime;

  //set phoneNo (String? phoneNo) => _phoneNo = phoneNo;

  // void updateInspectionDateOnly(
  //     {required int day, required int month, required int year}) {
  //   _inspectionStartTime =
  //       _inspectionStartTißme?.copyWith(day: day, year: year, month: month);
  //   validateBookingInspectionButton();
  // }

  void updateInspectionDateOnly(DateTime dateTime) {
    if (!_isStartTimeSelected) {
      _inspectionStartTime = dateTime.copyWith(hour: 9, minute: 0);
    } else {
      _inspectionStartTime = _inspectionStartTime?.copyWith(
          day: dateTime.day, year: dateTime.year, month: dateTime.month);
    }
    validateBookingInspectionButton();
  }

  // void updateInspectionStartTime(DateTime newDateTime) {
  //   _isStartTimeSelected = true;
  //   _inspectionStartTime = newDateTime;
  //   emit(CloseStartTimeRequestMessage());
  //   validateBookingInspectionButton();
  // }

  void validateBookingInspectionButton() {
    // TO DO: Add duration to validation
    if (_isStartTimeSelected && duration != null) {
      emit(BookInspectionButtonEnable());
    }
  }

  void selectDuration() {
    if (!_isStartTimeSelected) {
      emit(RequestStartTimeSelection());
    } else {
      emit(const ShowDurationSelection(true));
    }
  }

  set description(String desc) {
    _description = desc;
  }

  void updateProfilePhoneNumber(String phoneNo,
      {PhoneCode countryCode = PhoneCode.au}) async {
    try {
      final UserDetail user = await authenticationService.getCurrentUser();
      final String formatNumber = phoneNo.substring(1); // remove first zero
      await storageService.member.savePhoneNumberDetail(user.uid,
          PhoneNumber(countryCode: countryCode, phoneNumber: formatNumber));
      emit(UpdatePhoneNumberSuccessState());
    } on UserNotFoundException catch (_) {
      // TODO: Implement when there is no user
    }
  }

  void selectStartTime() {
    emit(ShowStartTimeSelection());
  }

  void closeBottomModal() {
    emit(CloseBottomSheet());
    validateBookingInspectionButton();
  }

  void saveBookingInspection(String propertyId) async {
    try {
      _inspectionEndTime =
          _inspectionStartTime?.add(Duration(minutes: _duration!));
      final UserDetail user = await authenticationService.getCurrentUser();
      final inspection = Inspection(
          propertyId: propertyId,
          startTime: _inspectionStartTime!,
          endTime: _inspectionEndTime!,
          message: _description,
          createdBy: user.uid);
      final String inspectionId =
          await storageService.inspection.addInspection(inspection);
      await storageService.member.addBookedInspection(inspectionId,
          user.uid); // add inspection to inpection user inspection list
      await storageService.property.addBookedInspection(inspectionId,
          propertyId); // add inspection to property inspection list
      emit(BookingInspectionSuccess());
    } catch (e) {
      emit(BookingInspectionFail());
    }
  }
}
