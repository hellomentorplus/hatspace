import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatspace/firebase_options.dart';
import 'package:hatspace/initial_app.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(
      name: 'Default-HatSpace',
      options: DefaultFirebaseOptions.currentPlatform);

  HsSingleton.singleton.initialise();

  runApp(const MyApp());
}
