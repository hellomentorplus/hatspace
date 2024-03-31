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
      final PhoneNumber? phoneNumber =
          await storageService.member.getMemberPhoneNumber(user.uid);
      if (userRole.contains(Roles.tenant)) {
        if (phoneNumber == null) {
          // Always set phoneNo string = null when open modal
          phoneNo = null;
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
  DateTime? inspectionStartTime;
  int? duration;
  bool isStartTimeSelected = false;
  DateTime? inspectionEndTime;
  String? phoneNo;
  String description = '';

  set startTime(DateTime? startTime) {
    inspectionStartTime = startTime;
    validateBookingInspectionButton();
  }

  DateTime? get startTime => inspectionStartTime;

  set endTime(DateTime? time) {
    inspectionEndTime = time;
  }

  DateTime? get endTime => inspectionEndTime;
  void updateInspectionDateOnly(
      {required int day, required int month, required int year}) {
    inspectionStartTime =
        inspectionStartTime?.copyWith(day: day, year: year, month: month);
    validateBookingInspectionButton();
  }

  void updateInspectionStartTime(DateTime newDateTime) {
    isStartTimeSelected = true;
    inspectionStartTime = newDateTime;
    emit(CloseStartTimeRequestMessage());
    validateBookingInspectionButton();
  }

  set durationTime(int? newDuration) {
    duration = newDuration;
    validateBookingInspectionButton();
  }

  int? get durationTime => duration;

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

  set descriptionProperty(String desc) {
    description = desc;
  }

  String get descriptionProperty => description;
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
      UserDetail user = await authenticationService.getCurrentUser();
      inspectionEndTime =
          inspectionStartTime?.add(Duration(minutes: durationTime!));
      final inspection = Inspection(
          propertyId: propertyId,
          startTime: inspectionStartTime!,
          endTime: inspectionEndTime!,
          message: description,
          createdBy: user.uid);
      final String inspectionId =
          await storageService.inspection.addInspection(inspection);
      await storageService.member.addBookedInspection(inspectionId,
          user.uid); // add inspection to inpection user inspection list
      await storageService.property.addBookedInspection(inspectionId,
          propertyId); // add inspection to property inspection list
      emit(BookingInspectionSuccess(inspectionId: inspectionId));
    } catch (e) {
      emit(BookingInspectionFail());
    }
  }
}
