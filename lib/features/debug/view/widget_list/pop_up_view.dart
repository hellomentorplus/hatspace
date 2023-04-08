import 'package:flutter/material.dart';

class PopupView extends StatefulWidget {
  const PopupView({super.key});

  @override
  State<PopupView> createState() => _ProgressIndicatorExampleState();
}

class _ProgressIndicatorExampleState extends State<PopupView>
    with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TextButton(
        onPressed: () {
          controller = AnimationController(
            duration: const Duration(seconds: 1),
            vsync: this,
          );
          controller.repeat();
          showDialog<String>(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Center(
                 child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      return CircularProgressIndicator(
                        value: controller.value,
                        strokeWidth: 10,
                        valueColor: controller.drive(ColorTween(
                            begin: const Color.fromARGB(255, 50, 168, 84),
                            end: const Color.fromARGB(125, 50, 168, 84))),
                      );
                    },
                ),
                const Text("Loading...")
              ],
            )
              )
               ),
          ).then((value) => controller.dispose());
        },
        child: const Text('Show Dialog'),
      ),
    ));
  }
}

