import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0, // Remove shadow from app bar background
            backgroundColor: HSColor.background,
            leading: Padding(
              padding: const EdgeInsets.only(top: 0, left: 10, right: 0),
              child: IconButton(
                icon: SvgPicture.asset(Assets.images.closeIcon),
                onPressed: () {
                  // ON PRESSED EVENT HERE
                },
              ),
            )),
        body: Padding(
            padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                      Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: SecondaryButton(
                            label: "Sign up with Google",
                            iconURL: Assets.images.google,
                            onPressed: () {},
                          )),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: SecondaryButton(
                            label: "Sign up with Facebook",
                            iconURL: Assets.images.facebookround,
                            onPressed: () {},
                          )),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: SecondaryButton(
                            label: "Sign up with email",
                            iconURL: Assets.images.envelope,
                            onPressed: () {},
                          )),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 52),
                          child: RichText(
                              text: TextSpan(
                                  style: textTheme.bodyMedium?.copyWith(
                                      fontSize: 12, color: HSColor.onSurface),
                                  text: "Already have account ? ",
                                  children: [
                                TextSpan(
                                    style:const  TextStyle(
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline),
                                    text: "Sign in",
                                    recognizer: TapGestureRecognizer()
                                      ..onTapDown = (details) {
                                        print("Tap down event");
                                      })
                              ]))),
                      TextOnlyButton(
                        label: "Skip",
                        onPressed: () {},
                      ),
                      const SizedBox(
                        height: 71,
                      )
                    ]))
              ],
            )));
  }
}
