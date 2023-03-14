import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

const isFirstLaunchConst = "isFirstLaunch";

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationService _authenticationService;

  SignUpBloc({AuthenticationService? authenticationService})
      : _authenticationService =
            authenticationService ?? AuthenticationService(),
        super(const SignUpInitial()) {
    on<SignUpEvent>((event, emit) {});

    on<CheckFirstLaunchSignUp>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? isLaunchFirstTime = prefs.getBool(isFirstLaunchConst);
      if (isLaunchFirstTime == null) {
        emit(const FirstLaunchScreen(true));
      }
    });

    on<CloseSignUpScreen>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(isFirstLaunchConst, false);

      emit(const FirstLaunchScreen(false));
    });

    on<SignUpWithGoolge>((event, emit) async {
      try {
        UserDetail? user = await _authenticationService.signUpWithGoogle();
        if (user != null) {
          return emit(const SignUpSuccess());
        }
      } on PlatformException {
        emit(SignUpFailed(
            SignUpStatusMessage.authenticationFaildMessage.toString()));
      }
    });
  }
}
