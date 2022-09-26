import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  void checkEmailAndPassword(String email, String password){
      if(email == "vinh@gmail.com" && password == "Vinh@123456789"){
        emit(SignInSuccess());
      }
  }
}
