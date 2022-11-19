import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(Assets.images.closeIcon),
                    alignment: Alignment.centerLeft),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have account ?",
                                style: textTheme.bodyMedium
                                    ?.copyWith(fontSize: 12)),
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Sign in",
                                  style: TextStyle(
                                      color: HSColor.onSurface,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w600),
                                ))
                          ],
                        ),
                      ),
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
