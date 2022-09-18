import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatspace/Screen/HomeScreen.dart';
import 'package:hatspace/cubit/sign_up_cubit.dart';

void main() {
  // Set default orientation with what we declare in [],
  // Also block landscape mode because it is not mentioned
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
        create: ((context) {
          return SignUpCubit();
        }),
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
