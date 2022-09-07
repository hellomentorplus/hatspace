import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatspace/Screen/HomeScreen.dart';

void main() {
  // Set default orientation with what we declare in [],
  // Also block landscape mode because it is not mentioned
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xff006606),
      ),
      home:  MyHomePage(),
    );
  }
}