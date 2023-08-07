import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hatspace/models/authentication/authentication_exception.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final String isFirstLaunchConst = 'isFirstLaunch';

  final AuthenticationService authenticationService =
      HsSingleton.singleton.get<AuthenticationService>();

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<_ValidateAuthentication>(_validateAuthentication);

    on<OnAppLaunchValidation>(_validateAuthenticationOnAppLaunch);

    on<SkipSignUp>(_skipSignUp);

    add(_ValidateAuthentication());
  }

  void _validateAuthentication(
      _ValidateAuthentication event, Emitter<AuthenticationState> emit) async {
    authenticationService.initialiseUserDetailStream();
    await emit.forEach(
      authenticationService.authenticationState,
      onData: (data) {
        if (data == null) {
          return AnonymousState();
        } else {
          SharedPreferences.getInstance().then(
            (pref) => pref.setBool(isFirstLaunchConst, false),
          );
          return AuthenticatedState(data);
        }
      },
    );
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
      try {
        // only check current user this time
        // because user state update before authentication bloc is initialised.
        final UserDetail detail = await authenticationService.getCurrentUser();
        emit(AuthenticatedState(detail));
      } on UserNotFoundException catch (_) {
        // do nothing
      }
    }
  }

  void _skipSignUp(SkipSignUp event, Emitter<AuthenticationState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isFirstLaunchConst, false);
    await authenticationService.signOut();
    emit(AnonymousState());
  }
}
