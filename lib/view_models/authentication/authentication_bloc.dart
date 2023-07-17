import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/data/data.dart';
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

  StreamSubscription<UserDetail?>? _streamSubscription;

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<ValidateAuthentication>(_validateAuthentication);

    on<OnAppLaunchValidation>(_validateAuthenticationOnAppLaunch);

    on<SkipSignUp>(_skipSignUp);
  }

  void _validateAuthentication(
      ValidateAuthentication event, Emitter<AuthenticationState> emit) async {
    _streamSubscription ??= authenticationService.authenticationState.listen((event) {
      if (event == null) {
        emit(AnonymousState());
      } else {
        emit(AuthenticatedState(event));
      }
    });
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
    await authenticationService.signOut();
    emit(AnonymousState());
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
