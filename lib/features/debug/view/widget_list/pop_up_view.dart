import 'package:flutter/material.dart';
import 'package:hatspace/theme/pop_up/pop_up_controller.dart';

Animatable<Color?> bgColor = TweenSequence<Color?>([
  TweenSequenceItem(
    weight: 1.0,
    tween: ColorTween(
            begin: const Color.fromARGB(255, 50, 168, 84),
                       end: const Color.fromARGB(125, 50, 168, 84)),
  ),
   TweenSequenceItem(
    weight: 1.0,
    tween: ColorTween(
            begin: const Color.fromARGB(255, 50, 168, 84),
                       end: const Color.fromARGB(125, 50, 168, 84)),
  ),
 TweenSequenceItem(
    weight: 1.0,
    tween: ColorTween(
            begin: const Color.fromARGB(255, 50, 168, 84),
                       end: const Color.fromARGB(125, 50, 168, 84)),
  ),
]);
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
            duration: const Duration(seconds: 2),
            vsync: this,
          );
          controller.repeat();
          context.showLoading();
        },
        child: const Text('Show Dialog'),
      ),
    ));
  }
}

