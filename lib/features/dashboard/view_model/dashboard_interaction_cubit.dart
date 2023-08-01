import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
part 'dashboard_interaction_state.dart';

enum BottomBarItems {
  explore,
  booking,
  message,
  profile,
  addingProperty;

  int get pageIndex {
    switch (this) {
      case BottomBarItems.explore:
        return 0;
      case BottomBarItems.booking:
        return 1;
      case BottomBarItems.message:
        return 2;
      case BottomBarItems.profile:
        return 3;
      default:
        return -1;
    }
  }
}

class DashboardInteractionCubit extends Cubit<DashboardInteractionState> {
  DashboardInteractionCubit() : super(DashboardInitial());

  final StorageService storageService =
      HsSingleton.singleton.get<StorageService>();
  final AuthenticationService authenticationService =
      HsSingleton.singleton.get<AuthenticationService>();
        BottomBarItems pressedBottomBarItem = BottomBarItems.explore;
  void onAddPropertyPressed() async {
    emit(StartValidateRole());
    try {
      final UserDetail detail = await authenticationService.getCurrentUser();

      final List<Roles> roles =
          await storageService.member.getUserRoles(detail.uid);

      if (!isClosed) {
        if (roles.contains(Roles.homeowner)) {
          emit(StartAddPropertyFlow());
        } else {
          emit(RequestHomeOwnerRole());
          // TODO handle when user is not a homeowner
        }
      }
    } on UserNotFoundException catch (_) {
      // TODO handle case when user is not login
    }
  }

  void onBottomItemTapped(BottomBarItems item) async {
    pressedBottomBarItem = item;
    bool isUserLoggedIn = authenticationService.isUserLoggedIn;
    if (!isUserLoggedIn) {
      return emit(OpenLoginBottomSheetModal(item));
    }
    switch (item) {
      case (BottomBarItems.addingProperty):
        onAddPropertyPressed();
        break;
      case (BottomBarItems.booking):
        emit(const OpenPage(BottomBarItems.booking)); break;
      case (BottomBarItems.message): 
        emit(const OpenPage(BottomBarItems.message)); break;
      case (BottomBarItems.profile):
      emit(const OpenPage(BottomBarItems.profile)); break;
      default:
        emit(OpenPage(item));
    }
  }

  void goToSignUpScreen() => emit(GotoSignUpScreen());

  void onCloseModal(item) => emit(CloseHsModal());
}
