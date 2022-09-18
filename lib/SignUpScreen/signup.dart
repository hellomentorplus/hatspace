import 'package:flutter/material.dart';
import 'package:hatspace/Screen/VerificationScreen.dart';
import 'package:hatspace/cubit/sign_up_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigUpScreen extends StatefulWidget {
  const SigUpScreen({Key? key}) : super(key: key);

  @override
  State<SigUpScreen> createState() => SigUpScreenState();
}

class SigUpScreenState extends State<SigUpScreen> {
  bool isBtnEnable = false;
  String emailValue = "";
  FocusNode textFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void initState() {
    _emailController.addListener(() {
      emailValue = _emailController.text.toLowerCase();
    });

    super.initState();
  }

  @override
  void dispose() {
    textFocusNode.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(builder: (context, state) {
      textFocusNode.addListener(() {
        if (!textFocusNode.hasFocus) {
          context.read<SignUpCubit>().validateEmail(_emailController.text);
        }
      });
      passwordFocusNode.addListener(() {
        if (!passwordFocusNode.hasFocus) {
          context
              .read<SignUpCubit>()
              .validatePassword(_passwordController.text);
        }
      });

      return Theme(
          data: ThemeData(
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            fixedSize: MaterialStateProperty.all<Size>(
              const Size.fromHeight(45),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromRGBO(255, 255, 255, 1)),
          ))),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).primaryColor,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      // color:Colors.amberAccent,
                      margin: const EdgeInsets.only(top: 60.0, bottom: 20.0),
                      child: Text("Space App",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium)),
                  Column(
                    children: [
                      Text(
                        "Space",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text("Please enter your email address",
                            style: Theme.of(context).textTheme.titleMedium),
                      ),
                      Container(
                          padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
                          child: TextField(
                            focusNode: textFocusNode,
                            controller: _emailController,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontSize: 20.0),
                            decoration: InputDecoration(
                              errorText: state.isEmailValid? null: state.emailError,
                              isCollapsed: true,
                              contentPadding: const EdgeInsets.all(10),
                              filled: true,
                              fillColor:
                                  const Color.fromRGBO(255, 255, 255, 0.4),
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0)),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                              hintText: "Email address",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontSize: 20.0),
                            ),
                          )),
                      Container(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                          child: TextField(
                            controller: _passwordController,
                            focusNode: passwordFocusNode,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontSize: 20.0),
                            decoration: InputDecoration(
                              errorText: state.isPasswordValid? null : state.passwordError,
                              isCollapsed: true,
                              contentPadding: const EdgeInsets.all(10),
                              filled: true,
                              fillColor:
                                  const Color.fromRGBO(255, 255, 255, 0.4),
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0)),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                              ),
                              hintText: "Password",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontSize: 20.0),
                            ),
                          )),
                  
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    // color:Colors.amberAccent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ElevatedButton(
                            style: ButtonStyle(backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              const Set<MaterialState> buttonState =
                                  <MaterialState>{MaterialState.disabled};
                              if (states.any(buttonState.contains)) {
                                return const Color.fromARGB(190, 255, 255, 255);
                              }
                              return const Color.fromRGBO(255, 255, 255, 1);
                            })),
                            onPressed:state.isEmailValid && state.isPasswordValid 
                                ? () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return VerificationPage(
                                          emailValue:
                                              _emailController.value.text);
                                    }));
                                  }
                                : null,
                            child: Text(
                              "Continue",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: Colors.black),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          child: Text.rich(
                            const TextSpan(children: [
                              WidgetSpan(
                                  child: Icon(Icons.add, color: Colors.black)),
                              TextSpan(text: "Sign in with Google"),
                            ]),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: Colors.black),
                          ),
                          onPressed: () {},
                        ),
                        const SizedBox(height: 10),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                children: const [
                                  TextSpan(text: "Made with "),
                                  TextSpan(
                                      text: "Glide",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ]))
                      ],
                    ),
                  )
                ]), // This trailing comma makes auto-formatting nicer for build methods.
          ));
    });
  }
}
