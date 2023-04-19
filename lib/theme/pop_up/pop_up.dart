import 'package:flutter/material.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_custom_loading.dart';

class PopUp extends StatefulWidget {
  const PopUp({super.key});
  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> with TickerProviderStateMixin {
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
        children: const [
          CustomLoading(
              duration: Duration(seconds: 1, milliseconds: 30),
              strokeCap: StrokeCap.round,
              radius: 12,
              strokeWidth: 4.0,
              gradientColors: [HSColor.onPrimary, HSColor.primary]),
          SizedBox(
            height: 16.0,
          ),
          Text("Loading...",
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
