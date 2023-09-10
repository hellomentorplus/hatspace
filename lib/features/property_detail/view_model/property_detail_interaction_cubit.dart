import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/features/property_detail/view_model/property_detail_interaction_state.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

class PropertyDetailInteractionCubit
    extends Cubit<PropertyDetailInteractionState> {
  PropertyDetailInteractionCubit() : super(PropertyDetailInteractionInitial());
  final AuthenticationService _authenticationService =
      HsSingleton.singleton.get<AuthenticationService>();

  void navigateToBooingInspectionScreen() {
    if (_authenticationService.isUserLoggedIn) {
      emit(NavigateToBooingInspectionScreen());
    } else {
      emit(ShowLoginBottomModal());
    }
  }

  void closeLoginModal() {
    emit(CloseLoginBottomModal());
  }
}
