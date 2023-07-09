import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
part 'home_interaction_state.dart';

enum BottomBarItems { explore, booking, message, profile, addingProperty }

class HomeInteractionCubit extends Cubit<HomeInteractionState> {
  HomeInteractionCubit() : super(HomeInitial());

  final StorageService storageService =
      HsSingleton.singleton.get<StorageService>();
  final AuthenticationService authenticationService =
      HsSingleton.singleton.get<AuthenticationService>();
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
          // TODO handle when user is not a homeowner
        }
      }
    } on UserNotFoundException catch (_) {}
  }

  void onBottomItemTapped(BottomBarItems item) async {
    bool isUserLoggedIn = await authenticationService.getIsUserLoggedIn();
    if (!isUserLoggedIn) {
      return emit(OpenLoginBottomSheetModal(item));
    }
    switch (item) {
      case (BottomBarItems.addingProperty):
        {
          onAddPropertyPressed();
        }
        // TODO: Handle navigate to others items
        break;
      default:
    }
  }

  void goToSignUpScreen (){
    emit(GotoSignUpScreen());
  }

  void onCloseModal() {
    emit(CloseHsModal());
  }
}
