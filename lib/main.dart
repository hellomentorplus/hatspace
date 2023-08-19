import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hatspace/firebase_options.dart';
import 'package:hatspace/initial_app.dart';
import 'package:hatspace/singleton/hs_singleton.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  // debugPaintSizeEnabled = true;
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(
      name: 'Default-HatSpace',
      options: DefaultFirebaseOptions.currentPlatform);

  HsSingleton.singleton.initialise();

  runApp(const MyApp());
}
