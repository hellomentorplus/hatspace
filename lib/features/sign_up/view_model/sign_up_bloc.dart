import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hatspace/models/authentication/authentication_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

const isFirstLaunchConst = "isFirstLaunch";

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationService _authenticationService;
  SignUpBloc({
    AuthenticationService? authenticationService
  }) : _authenticationService = authenticationService ?? AuthenticationService(),
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
    
    on<SignUpWithFacebook>((event, emit) async{
        final UserDetail? userDetail = await _authenticationService.signUpWithFacebook();
        if (userDetail != null){
          emit(const SignUpSuccess());
        }
        else{
            // TODO: Implement failed scenario
            // Scenario 1: user canceled (by press canceled and press X icon) - result.status == LoginStatus.cancelled
        }
    });
    
  }
}
