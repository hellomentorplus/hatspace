import 'package:flutter/material.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_buttons_settings.dart';

import '../../../../theme/hs_theme.dart';

class CoreButtonView extends StatelessWidget {
  final SizedBox sizedBox = const SizedBox(
    height: 10,
  );

  final List<Widget> buttonsList = [
    // Enabled Button with left icon
    PrimaryButton(
      label: "Sign up with Google",
      iconUrl: Assets.images.google,
      onPressed: () {},
    ),

    // Disabled button with left icon
    PrimaryButton(
      label: "Sign up with Google",
      iconUrl: Assets.images.google,
      contentAlignment: MainAxisAlignment.center,
      onPressed: null,
    ),

    //Enabled button with right icon
    PrimaryButton(
      label: "Sign up with Google",
      iconUrl: Assets.images.google,
      iconPosition: IconPosition.right,
      onPressed: () {},
    ),

    PrimaryButton(
      label: "Sign up",
      onPressed: (() {}),
    ),

    //Normal Secondary Button
    SecondaryButton(
      label: "Sign up with Facebook",
      contentAlignment: MainAxisAlignment.center,
      iconUrl: Assets.images.facebook,
      onPressed: (() {}),
    ),

    //Disabled Secondary Button
    SecondaryButton(
      label: "Sign up with Facebook",
      contentAlignment: MainAxisAlignment.start,
      iconUrl: Assets.images.facebook,
    ),
    SecondaryButton(
      label: "Sign up with Facebook",
      iconUrl: Assets.images.facebook,
      iconPosition: IconPosition.right,
      onPressed: () {},
    ),

    TextOnlyButton(
      label: "Skip",
      iconUrl: Assets.images.closeIcon,
      onPressed: (() {}),
    ),

    TertiaryButton(label: "Button", onPressed: () {}),
    TertiaryButton(
      label: "Button",
      onPressed: () {},
      iconUrl: Assets.images.calendar,
      iconPosition: IconPosition.right,
      contentAlignment: MainAxisAlignment.start,
    ),
    TertiaryButton(
      label: "Button",
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          //=====DISABLED EVENT
          if (states.contains(MaterialState.disabled)) {
            return HSColor.neutral3;
          } else {
            return const Color(0xFFFFF1F1);
          }
        }),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            //=====DISABLED EVENT
            if (states.contains(MaterialState.disabled)) {
              return HSColor.neutral5;
            } else {
              return const Color(0xFFFF3333);
            }
          },
        ),
        side: MaterialStateBorderSide.resolveWith(
          (states) {
            // Disabled EVENT
            if (states.contains(MaterialState.disabled)) {
              return const BorderSide(color: HSColor.neutral3);
            } else {
              return const BorderSide(color: Color(0xFFFFF1F1));
            }
          },
        ),
      ),
      iconUrl: Assets.images.calendar,
      iconPosition: IconPosition.right,
      contentAlignment: MainAxisAlignment.start,
    )
  ];

  CoreButtonView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Core button UI"),
      ),
      body: Column(
        children: [
          ListView.separated(
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            itemCount: buttonsList.length,
            itemBuilder: (context, index) {
              return Container(
                child: buttonsList[index],
              );
            },
            separatorBuilder: (context, index) {
              return sizedBox;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextOnlyButton(
                label: "Back",
                onPressed: () {},
                iconUrl: Assets.images.facebookround,
              ),
              PrimaryButton(
                  label: "Next",
                  iconUrl: Assets.images.email,
                  onPressed: () {},
                  iconPosition: IconPosition.right)
            ],
          )
        ],
      ),
    );
  }
}
