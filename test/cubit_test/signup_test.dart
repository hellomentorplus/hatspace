import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/Screen/VerificationScreen.dart';
import 'package:hatspace/cubit/sign_up_cubit.dart';

void main (){
    blocTest<SignUpCubit,SignUpState>(
      'Invalid Email',
      build: () => SignUpCubit(),
      act: (bloc) {
          return bloc.validateEmail("abcdefg");
      },
      expect: (){
        return [const SignUpState(isEmailValid:false,isPasswordValid: true,emailError:"Email is Invalid",passwordError: "")];
        } ,
    );

    blocTest<SignUpCubit,SignUpState>(
      'Email Required',
      build: () => SignUpCubit(),
      act: (bloc) {
          return bloc.validateEmail("");
      },
      expect: (){
        return [const SignUpState(isEmailValid:false,isPasswordValid: true,emailError:"Please Enter Email Address",passwordError: "")];
        } ,
    );

   blocTest<SignUpCubit,SignUpState>(
      'Test Password is too short',
      build: () => SignUpCubit(),
      act: (bloc) {
          return bloc.validatePassword("abc");
      },
      expect: (){
        return [const SignUpState(isEmailValid:true,isPasswordValid: false,emailError:"",passwordError: "Password is too short")];
        } ,
    );
     blocTest<SignUpCubit,SignUpState>(
      'At least 1 uppercase character',
      build: () => SignUpCubit(),
      act: (bloc) {
          return bloc.validatePassword("abcdef1qeqw");
      },
      expect: (){
        return [const SignUpState(isEmailValid:true,isPasswordValid: false,emailError:"",passwordError: "Password needs at least 1 uppercase character")];
        } ,
    );

     blocTest<SignUpCubit,SignUpState>(
      'At least 1 lower character',
      build: () => SignUpCubit(),
      act: (bloc) {
          return bloc.validatePassword("ASKDJLK12312");
      },
      expect: (){
        return [const SignUpState(isEmailValid:true,isPasswordValid: false,emailError:"",passwordError: "Password needs at least 1 lowercase character")];
        } ,
    );
    blocTest<SignUpCubit,SignUpState>(
      'At least 1 number',
      build: () => SignUpCubit(),
      act: (bloc) {
          return bloc.validatePassword("ASDKalskdlkl");
      },
      expect: (){
        return [const SignUpState(isEmailValid:true,isPasswordValid: false,emailError:"",passwordError: "Password needs at least 1 number")];
        } ,
    );
}