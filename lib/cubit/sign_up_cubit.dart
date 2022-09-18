import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());
  void validateEmail(String emailAddress) {
    RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (regex.hasMatch(emailAddress)) {
      // print("please input emial");
      emit(state.copyWith(isEmailValid: true));
    } else if (emailAddress == "") {
      emit(state.copyWith(
          isEmailValid: false, emailError: "Please Enter Email Address"));
    } else {
      emit(state.copyWith(isEmailValid: false, emailError: "Email is Invalid"));
    }
  }

  void validatePassword(String password) {
    RegExp regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
    //Check Less than 8 Charcter
    if (password.length < 8) {
      return emit(state.copyWith(
          isPasswordValid: false, passwordError: "Password is too short"));
    }
    // Check 1 uppercase character
    if (regex.hasMatch(password)) {
      emit(state.copyWith(isPasswordValid: true, passwordError: ""));
    } else {
      if(!password.contains(RegExp(r'[A-Z]'))){
        return emit(state.copyWith(isPasswordValid: false,passwordError:"Password needs at least 1 uppercase character" ));
      }
      if (!password.contains(RegExp(r'[a-z]'))){
        return emit(state.copyWith(isPasswordValid: false,passwordError:"Password needs at least 1 lowercase character" ));
      }
      if(!password.contains(RegExp(r'[0-9]'))){
        return emit(state.copyWith(isPasswordValid: false,passwordError:"Password needs at least 1 number" ));
      }
      emit(state.copyWith(
          isPasswordValid: false, passwordError: "Password Invalid"));
    }
  }
}
