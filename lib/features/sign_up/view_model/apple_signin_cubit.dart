import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

part 'apple_signin_state.dart';

class AppleSignInCubit extends Cubit<AppleSignInState> {
  AppleSignInCubit() : super(AppleSignInInitial());

  final AuthenticationService _authenticationService =
      HsSingleton.singleton.get<AuthenticationService>();

  void checkAppleSignInAvailable() {
    bool isAvailable = _authenticationService.isAppleSignInAvailable;
    if (isAvailable && defaultTargetPlatform == TargetPlatform.iOS) {
      emit(AppleSignInAvailable());
    }
  }
}
