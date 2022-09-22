import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatspace/ui/login_screen.dart';

import 'ui/verification_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white))),
        ),
        home: LoginScreen());
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF006607),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  'Space App',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                children: [
                  Text('Space',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .displayMedium
                          ?.copyWith(color: Colors.white)),
                  Text(
                    'Please enter your email address',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          fillColor: Colors.white.withOpacity(0.3),
                          filled: true,
                          hintText: 'Your Email address',
                          hintStyle: const TextStyle(color: Colors.white),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, bottom: 40.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => VerificationScreen(
                                    value: emailController.text)));
                          },
                          child: const Text(
                            'Continue',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        TextButton.icon(
                            onPressed: () => {},
                            icon: const Icon(
                              Icons.add_a_photo,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Sign in with Google',
                              style: TextStyle(color: Colors.black),
                            ))
                      ],
                    ),
                  ))
            ]),
      ),
    );
  }
}
