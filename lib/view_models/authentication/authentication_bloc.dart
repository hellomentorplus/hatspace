import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final String isFirstLaunchConst = 'isFirstLaunch';

  final AuthenticationService authenticationService =
      HsSingleton.singleton.get<AuthenticationService>();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<ValidateAuthentication>(_validateAuthentication);

    on<OnAppLaunchValidation>(_validateAuthenticationOnAppLaunch);

    on<SkipSignUp>(_skipSignUp);
  }

  void _validateAuthentication(
      ValidateAuthentication event, Emitter<AuthenticationState> emit) async {
    try {
      final UserDetail userDetail =
          await authenticationService.getCurrentUser();
      emit(AuthenticatedState(userDetail));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(isFirstLaunchConst, false);
    } on UserNotFoundException catch (_) {
      emit(AnonymousState());
    }
  }

  void _validateAuthenticationOnAppLaunch(
      OnAppLaunchValidation event, Emitter<AuthenticationState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLaunchFirstTime = prefs.getBool(isFirstLaunchConst);
    if (isLaunchFirstTime == null) {
      // sign out from any previous login session
      await authenticationService.signOut();
      emit(RequestSignUp());
    } else {
      add(ValidateAuthentication());
    }
  }

  void _skipSignUp(SkipSignUp event, Emitter<AuthenticationState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isFirstLaunchConst, false);
    emit(AnonymousState());
  }
}
