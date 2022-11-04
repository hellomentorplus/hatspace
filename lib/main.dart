import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< Updated upstream
import 'package:hatspace/features/home/view/home_view.dart';
import 'package:hatspace/firebase_options.dart';
import 'package:hatspace/models/authentication/authentication_bloc.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/strings/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
=======
import 'package:hatspace/Screen/HomeScreen.dart';
import 'package:hatspace/cubit/sign_in_cubit.dart';
import 'package:hatspace/cubit/sign_up_cubit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';

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
>>>>>>> Stashed changes

  HsSingleton.singleton.initialise();

<<<<<<< Updated upstream
  await Firebase.initializeApp(
    name: 'Default-HatSpace',
    options: DefaultFirebaseOptions.currentPlatform
  );
=======
// ===== Google Authentication ======
>>>>>>> Stashed changes

  runApp( MyApp());
}


class MyApp extends StatelessWidget {
<<<<<<< Updated upstream
  const MyApp({super.key});

  // This widget is the root of your application.
=======
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
>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(),
          )
          // TODO add your bloc creation here
        ],
<<<<<<< Updated upstream
        child: const HomePageView(),
      ),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        HatSpaceStrings.delegate
      ],
      supportedLocales: HatSpaceStrings.delegate.supportedLocales,
    );
=======
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              // Theme setup
              primaryColor: const Color(0xff3ACD64),
              backgroundColor: const Color(0xffF8F8F8),
              errorColor: const Color(0xffff3b30),
              colorScheme: myColorScheme,
              // Text Setup
              textTheme: const TextTheme(
                  // Title Setup
                  // LargeTitle
                  displayLarge: TextStyle(
                      letterSpacing: 0.25,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 41,
                      fontFamily: "BeVietnamPro"),

                  // H1
                  displayMedium: TextStyle(
                      letterSpacing: 0,
                      color: Colors.white,
                      fontSize: 26,
                      fontFamily: "BeVietnamPro"),
                  //H2
                  displaySmall: TextStyle(
                      height: 26,
                      letterSpacing: 0.15,
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "BeVietnamPro"),
                  // Subtitle
                  titleLarge: TextStyle(
                      letterSpacing: 0.15,
                      color: Color(0xff282828),
                      fontSize: 17,
                      fontFamily: "BeVietnamPro"),
                  //Body 1
                  bodyLarge: TextStyle(
                      letterSpacing: 0.5,
                      color: Color(0xff282828),
                      fontSize: 17,
                      fontFamily: 'BeVietnamPro'),
                  //body 2
                  bodyMedium: TextStyle(
                      letterSpacing: 0.4,
                      color: Color(0xff282828),
                      fontSize: 13,
                      fontFamily: "BeVietnamPro"),
                  // caption:
                  bodySmall: TextStyle(
                      letterSpacing: 0.4,
                      color: Color(0xff282828),
                      fontSize: 12,
                      fontFamily: "BeVietnamPro"),
                  //button
                  labelLarge: TextStyle(
                      letterSpacing: 1.25,
                      color: Color(0xff282828),
                      fontSize: 17,
                      fontFamily: "BeVietnamPro",
                      fontWeight: FontWeight.bold)),
              iconTheme: const IconThemeData(color: Colors.black, size: 15),
              //Button
              elevatedButtonTheme:  ElevatedButtonThemeData(
                style: ButtonStyle(
                  alignment: Alignment.centerLeft,
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(255, 255, 255, 1)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.fromLTRB(22, 17, 39, 17)),
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_){
                    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
                  }),
                  side: MaterialStateBorderSide.resolveWith((_){
                    return const BorderSide(color: Colors.black87 );
                  })
                  ) 
              )
              ),
              
          home: MyHomePage(),
        ));
>>>>>>> Stashed changes
  }
}