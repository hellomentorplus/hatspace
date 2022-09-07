import 'package:flutter/material.dart';

import 'verification_screen.dart';

void main() {
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
        home: const HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
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
                      decoration: InputDecoration(
                          fillColor: Colors.white.withOpacity(0.3),
                          filled: true,
                          hintText: 'Your Email address',
                          hintStyle: const TextStyle(color: Colors.white),
                          enabledBorder: const OutlineInputBorder(
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
                                builder: (context) =>
                                    const VerificationScreen()));
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
