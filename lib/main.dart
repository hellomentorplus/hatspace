import 'package:flutter/material.dart';

import 'verification_screen.dart';
// import 'package:hatspace/verification_screen.dart';

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
        home: Scaffold(
          backgroundColor: const Color(0xFF006607),
          body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'Space App',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.white),
                      ),
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
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextButton(
                              onPressed: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => const SecondRoute()));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const VerificationScreen()));
                              },
                              child: const Text(
                                'Continue',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            TextButton(
                                onPressed: () => {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Sign in with Google',
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ))
                ]),
          ),
        ));
  }
}

// class SecondRoute extends StatelessWidget {
//   const SecondRoute({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Second Route'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text('Go back!'),
//         ),
//       ),
//     );
//   }
// }
