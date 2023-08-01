import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

part 'my_profile_state.dart';

class MyProfileCubit extends Cubit<MyProfileState> {
  final AuthenticationService _authenticationService =
      HsSingleton.singleton.get<AuthenticationService>();
  MyProfileCubit() : super(const MyProfileInitialState());

  void getUserInformation() async {
    try {
      emit(const GettingUserInformationState());
      final UserDetail user = await _authenticationService.getCurrentUser();
      emit(GetUserInformationSucceedState(user));
    } catch (_) {
      emit(const GetUserInformationFailedState());
    }
  }
}
