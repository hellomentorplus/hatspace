import 'package:flutter/material.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class CoreButtonView extends StatelessWidget {
  SizedBox sizedBox = const SizedBox(
    height: 10,
  );

  List<Widget> buttonsList = [
    PrimaryButton(
      label: "Sign up with Google",
      iconUrl: Assets.images.google,
      onPressed: () {},
    ),
    PrimaryButton(
      label: "Sign up",
      onPressed: (() {}),
    ),
    SecondaryButton(
      label: "Sign up with Google",
      iconURL: Assets.images.google,
      onPressed: (() {}),
    ),
    SecondaryButton(label: "Sign up", onPressed: (() {})),
    TextOnlyButton(label: "Skip", onPressed: (() {}))
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Core button UI"),
        ),
        body: ListView.separated(
          padding: EdgeInsets.all(10),
          itemCount: buttonsList.length,
          itemBuilder: (context, index) {
            return Container(
              child: buttonsList[index],
            );
          },
          separatorBuilder: (context, index) {
            return sizedBox;
          },
        ));
  }
}

//  crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const Text("Primary Buttons Theme", textAlign: TextAlign.center, style: TextStyle(
//             fontSize: 25,
//             fontWeight: FontWeight.bold
//           ),),
//           sizedBox,
//           PrimaryButton(
//             label: "Primary Button",
//             iconUrl: Assets.images.facebook,
//             onPressed: (() {
//               // For Testing only - will not perform any actions
//             }),
//           ),
//           sizedBox,
//           PrimaryButton(
//             label: "No icon",
//             onPressed: ((){
//               // Do nothing
//             }),
//           ),
//           sizedBox,
//           SecondaryButton(
//             label: "Secondary Button",
//             iconURL: Assets.images.google,
//             onPressed: ((() {
//               // Doing nothing
//             })),
//           ),

//         ],
