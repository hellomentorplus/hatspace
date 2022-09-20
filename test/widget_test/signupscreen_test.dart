import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatspace/SignUpScreen/signup.dart';
import 'package:hatspace/cubit/sign_up_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signupscreen_test.mocks.dart';
@GenerateMocks([SignUpCubit])
void main (){
  testWidgets("Email error message", (widgetTester)async{
    // await tester.wrapAndPumpWidget(const SigUpScreen());
    Widget widget = const SigUpScreen();

    final MockSignUpCubit signUpCubit = MockSignUpCubit();
    when(signUpCubit.state).thenAnswer((realInvocation) =>const SignUpState(isEmailValid:false,isPasswordValid: true,emailError:"Email is Invalid",passwordError: "") );
    when(signUpCubit.stream).thenAnswer((realInvocation) => Stream.value(const SignUpState(isEmailValid:false,isPasswordValid: true,emailError:"Email is Invalid",passwordError: "")));

    final Widget blocWrapper = BlocProvider<SignUpCubit>(
      create: (context)=> signUpCubit,
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primaryColor: const Color(0xff006606),
              textTheme: const TextTheme(
                displayMedium:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                titleLarge: TextStyle(color: Colors.white),
                titleMedium:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
              ),
              iconTheme: const IconThemeData(color: Colors.black, size: 15)),
          home: Builder(builder: (context)=>widget,)
        ),
      );

    await widgetTester.pumpWidget(blocWrapper);
    // await widgetTester.pumpFrames(blocWrapper, const Duration(milliseconds: 160));
    // await tester.pumpFrames(const SigUpScreen(),const Duration(milliseconds: 160));
    Iterable <TextField> textFieldList = widgetTester.widgetList(find.byType(TextField));
    TextField emailTextField = textFieldList.first;
    expect(emailTextField.decoration?.errorText, "Email is Invalid");

  });

}


