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
  testWidgets("Email error message", (WidgetTester tester)async{
    await tester.wrapAndPumpWidget(const SigUpScreen());

    final MockSignUpCubit signUpCubit = MockSignUpCubit();
    when(signUpCubit.state).thenAnswer((realInvocation) =>const SignUpState() );
    when(signUpCubit.stream).thenAnswer((realInvocation) => Stream.value(const SignUpState(isEmailValid: true)));
   expect(signUpCubit.state.emailError, "invalid email");

  });

}


extension WidgetTesterExtension on WidgetTester{
  Future<void> wrapAndPumpWidget(Widget widget)async{
    await pumpWidget( 
       BlocProvider<SignUpCubit>(
        create: ((context) {
          return SignUpCubit();
        }),
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
          home: widget,
        )));
    await pump();
  }
}