import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/features/home/view/home_view.dart';
import 'package:hatspace/features/sign_up/view_model/sign_up_bloc.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
        listenWhen: (context, state) {
          return state is FirstLaunchScreen && state.isFirstLaunch == false;
        },
        listener: (context, state) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return HomePageView();
          }));
        },
        child: Scaffold(
            appBar: AppBar(
                elevation: 0, // Remove shadow from app bar background
                backgroundColor: HSColor.background,
                leading: Padding(
                  padding: const EdgeInsets.only(top: 0, left: 10, right: 0),
                  child: IconButton(
                    icon: SvgPicture.asset(Assets.images.closeIcon),
                    onPressed: () {
                      context.read<SignUpBloc>().add(const CloseSignUpScreen());
                    },
                  ),
                )),
            body: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 71),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SecondaryButton(
                          label: HatSpaceStrings.of(context).googleSignUp,
                          iconURL: Assets.images.google,
                          onPressed: () {},
                        )),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SecondaryButton(
                          label: HatSpaceStrings.of(context).facebookSignUp,
                          iconURL: Assets.images.facebookround,
                          onPressed: () {},
                        )),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: SecondaryButton(
                          label: HatSpaceStrings.of(context).emailSignUp,
                          iconURL: Assets.images.envelope,
                          onPressed: () {},
                        )),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 52),
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                style: textTheme.bodyMedium?.copyWith(
                                  fontSize: 12,
                                  color: HSColor.onSurface,
                                ),
                                children: [
                                  TextSpan(
                                      style: textTheme.bodyMedium?.copyWith(
                                          fontSize: 12,
                                          color: HSColor.onSurface),
                                      text: HatSpaceStrings.of(context)
                                          .alreadyHaveAccount),
                                  TextSpan(
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline),
                                      text: HatSpaceStrings.of(context).signIn,
                                      recognizer: TapGestureRecognizer()
                                        ..onTapDown = (details) {
                                          // On tab down event here
                                        })
                                ]))),
                    TextOnlyButton(
                      label: HatSpaceStrings.of(context).skip,
                      onPressed: () {
                        context
                            .read<SignUpBloc>()
                            .add(const CloseSignUpScreen());
                      },
                    ),
                  ]),
            )));
  }
}
