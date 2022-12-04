import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatspace/firebase_options.dart';
import 'package:hatspace/initial_app.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? showFirstSignUp;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  showFirstSignUp = (await prefs.getBool("showFirstSignUp"));
  if (showFirstSignUp == null) {
    await prefs.setBool("showFirstSignUp", true);
  }
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  HsSingleton.singleton.initialise();

  await Firebase.initializeApp(
      name: 'Default-HatSpace',
      options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}
