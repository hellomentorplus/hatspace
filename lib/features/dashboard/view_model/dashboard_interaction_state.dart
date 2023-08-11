part of 'dashboard_interaction_cubit.dart';

abstract class DashboardInteractionState extends Equatable {
  const DashboardInteractionState();
}

class DashboardInitial extends DashboardInteractionState {
  @override
  List<Object> get props => [];
}

class StartValidateRole extends DashboardInteractionState {
  @override
  List<Object?> get props => [];
}

class RequestHomeOwnerRole extends DashboardInteractionState {
  @override
  List<Object?> get props => [];
}

class OpenLoginBottomSheetModal extends DashboardInteractionState {
  final BottomBarItems item;

  const OpenLoginBottomSheetModal(this.item);

  @override
  List<Object?> get props => [item];
}

class GotoSignUpScreen extends DashboardInteractionState {
  @override
  List<Object?> get props => [];
}

class OpenPage extends DashboardInteractionState {
  final BottomBarItems item;

  const OpenPage(this.item);

  @override
  List<Object?> get props => [item];
}

class CloseRequestHomeOwnerModal extends DashboardInteractionState {
  @override
  List<Object?> get props => [];
}

class CloseLoginModal extends DashboardInteractionState {
  @override
  List<Object?> get props => [];
}

class PhotoPermissionGranted extends DashboardInteractionState {
  @override
  List<Object?> get props => [];
}

class PhotoPermissionDenied extends DashboardInteractionState {
  @override
  List<Object?> get props => [];
}

class PhotoPermissionDeniedForever extends DashboardInteractionState {
  @override
  List<Object?> get props => [];
}

class CancelPhotoAccess extends DashboardInteractionState {
  @override
  List<Object?> get props => [];
}

class OpenSettingScreen extends DashboardInteractionState {
  @override
  List<Object?> get props => [];
}

class DismissPhotoPermissionBottomSheet extends DashboardInteractionState {
  @override
  List<Object?> get props => [];
}

class NavigateToAddPropertyFlow extends DashboardInteractionState {
  @override
  List<Object?> get props => [];
}
