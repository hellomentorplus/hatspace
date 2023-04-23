import 'package:flutter/material.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_custom_loading.dart';

class PopUp extends StatelessWidget {
  const PopUp({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: HSColor.onPrimary,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomLoading(),
          const SizedBox(
            height: 16.0,
          ),
          Text(HatSpaceStrings.of(context).loadingMessage,
              style: const TextStyle(
                  //Todo: Change style when material change
                  color: Color.fromARGB(255, 20, 20, 20),
                  fontWeight: FontWeight.w500,
                  fontSize: 14))
        ],
      ),
    );
  }
}
