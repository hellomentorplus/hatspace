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
      UserDetail user = await authenticationService.getCurrentUser();
      List<Roles> userRole = await storageService.member.getUserRoles(user.uid);
      PhoneNumber? phoneNumber =
          await storageService.member.getMemberPhoneNumber(user.uid);
      if (userRole.contains(Roles.tenant)) {
        if (phoneNumber == null) {
          // Always set phoneNo string = null when open modal
          phoneNo = null;
          return emit(ShowUpdateProfileModal());
        }
        inspectionEndTime =
            _inspecitonStartTime?.add(Duration(minutes: durationTime!));
        Inspection inspection = Inspection(
            propertyId: propertyId,
            startTime: inspectionStartTime!,
            endTime: inspectionEndTime!,
            message: description,
            createdBy: user.uid);
        saveBookingInspection(inspection, user.uid);
      }
      if (userRole.isEmpty) {
        // TODO: HANDLE when user has no roles
      }
    } on UserNotFoundException catch (_) {
      // TODO: Implement when there is no user
    }
  }

  // only get day, month, and year at the first time. StartTime need to be updated in UI
  DateTime? _inspecitonStartTime;
  int? _duration;
  bool isStartTimeSelected = false;
  DateTime? inspectionEndTime;
  String? phoneNo;
  String _description = '';
  set inspectionStartTime(DateTime? startTime) {
    _inspecitonStartTime = startTime;
    validateBookingInspectionButton();
  }

  DateTime? get inspectionStartTime => _inspecitonStartTime;

  void updateInspectionDateOnly(
      {required int day, required int month, required int year}) {
    inspectionStartTime =
        _inspecitonStartTime?.copyWith(day: day, year: year, month: month);
    validateBookingInspectionButton();
  }

  void updateInspectionStartTime(DateTime newDateTime) {
    isStartTimeSelected = true;
    _inspecitonStartTime = newDateTime;
    emit(CloseStartTimeRequestMessage());
    validateBookingInspectionButton();
  }

  set duration(int? newDuration) {
    _duration = newDuration;
    validateBookingInspectionButton();
  }

  int? get durationTime => _duration;

  void validateBookingInspectionButton() {
    // TO DO: Add duration to validation
    if (isStartTimeSelected && durationTime != null) {
      emit(BookInspectionButtonEnable());
    }
  }

  void selectDuration() {
    if (!isStartTimeSelected) {
      emit(RequestStartTimeSelection());
    } else {
      emit(const ShowDurationSelection(true));
    }
  }

  set description(String description){
    _description = description;
  }

  String get description =>  _description;

  void updateProfilePhoneNumber(String phoneNo,
      {PhoneCode countryCode = PhoneCode.au}) async {
    try {
      UserDetail user = await authenticationService.getCurrentUser();
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

  void saveBookingInspection(Inspection newInspection, String uid) async {
    try {
      String inspectionId = await storageService.property.addInspection(newInspection);
      await storageService.member.addBookedInspection(inspectionId, uid);
      emit(BookingInspectionSuccess());
    } catch (e) {
      emit(BookingInspectionFail());
    }
  }
}
