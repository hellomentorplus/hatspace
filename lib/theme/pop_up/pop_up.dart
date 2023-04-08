import 'package:flutter/material.dart';
import 'package:hatspace/theme/hs_theme.dart';

class PopUp extends StatefulWidget {
  const PopUp({super.key});

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp>
    with TickerProviderStateMixin {
  late AnimationController controller;
  
  @override
  void initState() {
    controller = AnimationController(
            duration: const Duration(seconds: 2),
            vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
  shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0))),
  title: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      CircularProgressIndicator(
        backgroundColor: Color.fromARGB(124, 151, 151, 151),
        strokeWidth: 5,
      ),
      SizedBox(
        height: 16.0,
      ),
      Text("Loading...",style: TextStyle(
        //Todo: Change style when material change
        color: Color.fromARGB(255,20, 20, 20),
        fontWeight: FontWeight.w500,
        fontSize: 14
      ))
    ],
  ),
);
  }
}