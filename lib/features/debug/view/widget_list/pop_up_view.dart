import 'package:flutter/material.dart';
import 'package:hatspace/theme/pop_up/pop_up_controller.dart';

class PopupView extends StatelessWidget {
  const PopupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TextButton(
        onPressed: () {
          context.showLoading();
        },
        child: const Text('Show Dialog'),
      ),
    ));
  }
}
