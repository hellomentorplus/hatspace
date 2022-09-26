import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/Screen/HomeScreen.dart';
import 'package:hatspace/cubit/sign_in_cubit.dart';
import 'package:hatspace/cubit/sign_up_cubit.dart';

import 'firebase_options.dart';

Future<void> main() async {
  // Set default orientation with what we declare in [],
  // Also block landscape mode because it is not mentioned
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyDDBEW5klgondSEp0kxwNOgTSBNWF4MFi8',
    appId: '1:8474379889:android:183669eec897bccdbbfdd0',
    messagingSenderId: '8474379889',
    projectId: 'auth-flutter-test-d3a5a',
    storageBucket: 'auth-flutter-test-d3a5a.appspot.com',
  ));
  // try {
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: "admin@gmail.com", 
  //       password: "Admin@123");
  // } catch (err) {}
  // ;

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // Set up Firebase authentication
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
      
    }
  });

// await FirebaseAuth.instance.signOut();



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SignUpCubit>(create: ((context) {
            return SignUpCubit();
          })),
          BlocProvider<SignInCubit>(create: (context) {
            return SignInCubit();
          })
        ],
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
          home: MyHomePage(),
        ));
  }
}
