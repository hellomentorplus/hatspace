import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../exception/authentication_exception.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

const isFirstLaunchConst = "isFirstLaunch";

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationService _authenticationService;

  SignUpBloc({AuthenticationService? authenticationService})
      : _authenticationService =
            authenticationService ?? AuthenticationService(),
        super(const SignUpInitial()) {
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
        await _authenticationService.signUpWithGoogle();
        emit(const SignUpSuccess());
      } on UserCancelException {
        emit(UserCancelled());
      } on UserNotFoundException {
        emit(AuthenticationFailed());
      }
    });
  }
}
