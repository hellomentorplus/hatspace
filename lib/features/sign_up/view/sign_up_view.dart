import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/features/sign_up/view_model/sign_up_bloc.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/pop_up/pop_up_controller.dart';
import 'package:hatspace/theme/toast_messages/hs_toast_theme.dart';
import 'package:hatspace/theme/toast_messages/toast_messages_extension.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpStart) {
            context.showLoading();
          }

          if (state is FirstLaunchScreen && state.isFirstLaunch == false) {
            // dismiss this page and return to home
            context.pop();
          }

          if (state is UserCancelled || state is AuthenticationFailed) {
            context.dismissLoading();
            context.showToast(
                type: ToastType.errorToast,
                title: HatSpaceStrings.of(context).signinErrorToastTitle,
                message: HatSpaceStrings.of(context).signinErrorToastMessage);
          }
          if (state is UserRolesUnavailable) {
            context.dismissLoading();
            context.goToChooseRole();
          }
          if (state is SignUpSuccess) {
            context.dismissLoading();
            context.pop();
          }
        },
        child: Scaffold(
            body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Assets.images.signInBackground.provider(),
                      fit: BoxFit.cover)),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 4,
                    sigmaY:
                        4), // Adjust the sigma values for desired blur intensity
                child: Container(
                  color: Colors.black
                      .withOpacity(0.3), // Adjust the opacity and color
                ),
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    TextOnlyButton(
                      label: HatSpaceStrings.current.skip,
                      onPressed: () {
                        context
                            .read<SignUpBloc>()
                            .add(const CloseSignUpScreen());
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                          colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(top: 150.0, bottom: 80.0),
                    child: SizedBox(
                      width: 150.0,
                      height: 150.0,
                      child: SvgPicture.asset(Assets.images.logo),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: SecondaryButton(
                            contentAlignment: MainAxisAlignment.start,
                            label: HatSpaceStrings.of(context).emailSignUp,
                            iconUrl: Assets.icons.envelope,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      const EdgeInsets.all(16.0)),
                            ),
                            onPressed: () {},
                          )),
                      Padding(
                          padding:
                              const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
                          child: SecondaryButton(
                            contentAlignment: MainAxisAlignment.start,
                            label: HatSpaceStrings.of(context).facebookSignUp,
                            iconUrl: Assets.icons.facebook,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      const EdgeInsets.all(16.0)),
                              iconColor: MaterialStateProperty.all<Color>(
                                  const Color(0xFF3C65CE)),
                            ),
                            onPressed: () {
                              context
                                  .read<SignUpBloc>()
                                  .add(const SignUpWithFacebook());
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: SecondaryButton(
                            contentAlignment: MainAxisAlignment.start,
                            label: HatSpaceStrings.of(context).googleSignUp,
                            iconUrl: Assets.icons.google,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      const EdgeInsets.all(16.0)),
                            ),
                            onPressed: () {
                              context
                                  .read<SignUpBloc>()
                                  .add(const SignUpWithGoogle());
                            },
                          )),
                    ],
                  ))
                ],
              ),
            ),
          ],
        )));
  }
}
