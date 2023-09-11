import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/features/property_detail/view_model/property_detail_interaction_state.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/models/storage/storage_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

class PropertyDetailInteractionCubit
    extends Cubit<PropertyDetailInteractionState> {
  PropertyDetailInteractionCubit() : super(PropertyDetailInteractionInitial());
  final AuthenticationService _authenticationService =
      HsSingleton.singleton.get<AuthenticationService>();
  final StorageService _storageService =
      HsSingleton.singleton.get<StorageService>();
  void navigateToBooingInspectionScreen() async {
    try {
      // Check when user logged in yet
      if (_authenticationService.isUserLoggedIn) {
        UserDetail userDetail = await _authenticationService.getCurrentUser();
        List<Roles> userRoles =
            await _storageService.member.getUserRoles(userDetail.uid);
        // when user does not have tenant role.
        if (!userRoles.contains(Roles.tenant)) {
          emit(RequestTenantRoles());
        } else {
          emit(NavigateToBooingInspectionScreen());
        }
      } else {
        emit(ShowLoginBottomModal());
      }
    } on UserNotFoundException catch (_) {
      // TODO: Verify when user not found
    }
  }

  void closeLoginModal() {
    emit(CloseLoginBottomModal());
  }
}
