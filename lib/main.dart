import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatspace/firebase_options.dart';
import 'package:hatspace/initial_app.dart';
import 'package:hatspace/models/remote_config/remote_config_service.dart';
import 'package:hatspace/singleton/hs_singleton.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  HsSingleton.singleton.initialise();

  await Firebase.initializeApp(
      name: 'Default-HatSpace',
      options: DefaultFirebaseOptions.currentPlatform);
  final remoteConfigInstance = FirebaseRemoteConfig.instance;
  RemoteConfigService remoteConfigService =
      RemoteConfigService(firebaseRemoteConfig: remoteConfigInstance);
  await remoteConfigService.initialise();

  runApp(const MyApp());
}
