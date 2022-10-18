
part of 'sign_up_cubit.dart';
 class SignUpState extends Equatable {
final bool isEmailValid;
  final bool isPasswordValid; 
  final String? emailError;
  final String? passwordError;
  const SignUpState({this.isEmailValid = false,this.isPasswordValid=false, this.emailError="", this.passwordError=""});
  
  @override
  List<Object?> get props => [isEmailValid,isPasswordValid,emailError,passwordError];
 SignUpState copyWith({
  bool? isEmailValid,
  bool?  isPasswordValid,
  String? emailError,
  String? passwordError,
 }){return SignUpState(
  isEmailValid: isEmailValid ?? this.isEmailValid,
  emailError: emailError ?? this.emailError ,
  isPasswordValid: isPasswordValid ?? this.isPasswordValid,
  passwordError: passwordError?? this.passwordError,
 );
 }
}

class SignUpSuccessState extends SignUpState{
    
}
class SignUpFailState extends SignUpState{
  final String? message;
  const SignUpFailState(this.message);
}
