import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatspace/firebase_options.dart';
import 'package:hatspace/initial_app.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:hatspace/theme/hs_theme.dart';
// import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  HsSingleton.singleton.initialise();

  await Firebase.initializeApp(
      name: 'Default-HatSpace',
      options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}
