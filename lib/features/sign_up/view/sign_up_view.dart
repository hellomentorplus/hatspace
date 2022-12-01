import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/features/home/view/home_view.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/**
 *  TODO: - Add function to navigate to DUMY HOME PAGE / BLOCK: Waiting for Tai
 * 
 */
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          HatSpaceStrings.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Scaffold(
            appBar: AppBar(
                elevation: 0, // Remove shadow from app bar background
                backgroundColor: HSColor.background,
                leading: Padding(
                  padding: const EdgeInsets.only(top: 0, left: 10, right: 0),
                  child: IconButton(
                    icon: SvgPicture.asset(Assets.images.closeIcon),
                    onPressed: () {
                      // ON PRESSED EVENT HERE
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePageView()));
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
                                label:
                                    HatSpaceStrings.of(context)!.googleSignUp,
                                iconURL: Assets.images.google,
                                onPressed: () {},
                              )),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: SecondaryButton(
                                label:
                                    HatSpaceStrings.of(context)!.facebookSignUp,
                                iconURL: Assets.images.facebookround,
                                onPressed: () {},
                              )),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 18),
                              child: SecondaryButton(
                                label: HatSpaceStrings.of(context)!.emailSignUp,
                                iconURL: Assets.images.envelope,
                                onPressed: () {},
                              )),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 52),
                              child: RichText(
                                  text: TextSpan(
                                      style: textTheme.bodyMedium?.copyWith(
                                          fontSize: 12,
                                          color: HSColor.onSurface),
                                      children: [
                                    TextSpan(
                                        style: textTheme.bodyMedium?.copyWith(
                                            fontSize: 12,
                                            color: HSColor.onSurface),
                                        text: "Already have account ? "),
                                    TextSpan(
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                                TextDecoration.underline),
                                        text: "Sign in",
                                        recognizer: TapGestureRecognizer()
                                          ..onTapDown = (details) {
                                            print("Tap down event");
                                          })
                                  ]))),
                          TextOnlyButton(
                            label: "Skip",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => HomePageView())));
                            },
                          ),
                          const SizedBox(
                            height: 71,
                          )
                        ]))
                  ],
                ))));
  }
}
