import 'package:flutter/material.dart';
import 'package:hatspace/theme/hs_theme.dart';

class PopUp extends StatefulWidget {
  const PopUp({super.key});
  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> with TickerProviderStateMixin {
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
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    controller.repeat();
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return CircularProgressIndicator(
                  value: controller.value,
                  valueColor: controller.drive(ColorTween(
                      begin: const Color.fromARGB(255, 50, 168, 84),
                      end: const Color.fromARGB(125, 50, 168, 84))),
                  // backgroundColor: Color.fromARGB(125,50, 168, 84),
                  strokeWidth: 5,
                );
              }),
          const SizedBox(
            height: 16.0,
          ),
          const Text("Loading...",
              style: TextStyle(
                  //Todo: Change style when material change
                  color: Color.fromARGB(255, 20, 20, 20),
                  fontWeight: FontWeight.w500,
                  fontSize: 14))
        ],
      ),
    );
  }
}
