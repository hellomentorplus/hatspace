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
    emit(const GettingUserInformationState());
    _authenticationService.getCurrentUser().then(
      (user) => emit(GetUserInformationSucceedState(user)),
      onError: (_) => emit(const GetUserInformationFailedState()),
    );
  }
}
