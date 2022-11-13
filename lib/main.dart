import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/Screen/HomeScreen.dart';
import 'package:hatspace/cubit/sign_in_cubit.dart';
import 'package:hatspace/cubit/sign_up_cubit.dart';
import 'package:hatspace/firebase_options.dart';
import 'package:hatspace/theme/color_theme/hs_theme.dart';



Future<void> main() async {
  // Set default orientation with what we declare in [],
  // Also block landscape mode because it is not mentioned
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //   apiKey: 'AIzaSyDDBEW5klgondSEp0kxwNOgTSBNWF4MFi8',
  //   appId: '1:8474379889:android:183669eec897bccdbbfdd0',
  //   messagingSenderId: '8474379889',
  //   projectId: 'auth-flutter-test-d3a5a',
  //   storageBucket: 'auth-flutter-test-d3a5a.appspot.com',
  // ));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // try {
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: "admin@gmail.com",
  //       password: "Admin@123");
  // } catch (err) {}
  // ;

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // Set up Firebase authentication
  // FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     print('User is signed in!');
  //   }
  // });
// await FirebaseAuth.instance.signOut();

// ===== Google Authentication ======

  runApp( MyApp());
}



class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
   ColorScheme myColorScheme  = const ColorScheme(brightness: Brightness.light,
                primary:  Color(0xff3acd64),
                onPrimary:  Color(0xff282828),
                secondary:  Color(0xffa195fe),
                onSecondary: Color.fromRGBO(255, 255, 255, 1),
                background:  Color(0xffff3b30),
                onBackground:  Color(0xffff3b30),
                surface:  Color.fromRGBO(255, 255, 255, 1),
                onSurface:  Color.fromRGBO(255, 255, 255, 1),
                error:  Color(0xffff3b30),
                onError:  Color(0xffff3b30));
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  
      home: MultiBlocProvider(
        providers: [
          BlocProvider<SignUpCubit>(create: ((context) {
            return SignUpCubit();
          })),
          BlocProvider<SignInCubit>(create: (context) {
            return SignInCubit();
          })
          // TODO add your bloc creation here
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              // Theme setup
              primaryColor: const Color(0xff3ACD64),
              backgroundColor: const Color(0xffF8F8F8),
              errorColor: const Color(0xffff3b30),
              colorScheme: colorScheme,
              // Text Setup
             
              iconTheme: const IconThemeData(color: Colors.black, size: 15),
              //Button
             
              ),
              
          home: MyHomePage(),
        )));
  }
}