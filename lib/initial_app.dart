import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/features/home/view/home_view.dart';
import 'package:hatspace/features/sign_up/view/sign_up_view.dart';
import 'package:hatspace/models/authentication/authentication_bloc.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget initiallWidget = HomePageView();
    return MultiBlocProvider(providers: [
      BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(),
      )
      // TODO add your bloc creation here
    ], child: MaterialApp(
      theme: lightThemeData,
      home: FutureBuilder(
          future: InititalLaunchCheck().getBooleanValue("showFirstSignUp"),
          builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
            if (snapshot.data == true) {
              return const SignUpScreen();
            } else {
              return initiallWidget;
            }
          },
        ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        HatSpaceStrings.delegate
      ],
      supportedLocales: HatSpaceStrings.delegate.supportedLocales,
    ));
  }
}

class InititalLaunchCheck {
  Future<bool?> getBooleanValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getBool(key);
  }
}
