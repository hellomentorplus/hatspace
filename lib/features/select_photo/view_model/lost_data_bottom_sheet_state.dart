part of 'lost_data_bottom_sheet_cubit.dart';

abstract class LostDataBottomSheetState {
  const LostDataBottomSheetState();
}

class LostDataBottomSheetInitial extends LostDataBottomSheetState {}

class OpenLostDataBottomSheet extends LostDataBottomSheetState {}

class CloseLostDataBottomSheet extends LostDataBottomSheetState {}

class ExitSelectPhoto extends LostDataBottomSheetState {}