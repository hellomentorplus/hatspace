import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/sign_up/view_model/sign_up_bloc.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/pop_up/pop_up_controller.dart';
import 'package:hatspace/theme/toast_messages/hs_toast_theme.dart';
import 'package:hatspace/theme/toast_messages/toast_messages_extension.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/view_models/authentication/authentication_bloc.dart';
import 'package:flutter/foundation.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<SignUpBloc>(
        create: (context) => SignUpBloc(),
        child: const SignUpBody(),
      );
}

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpStart) {
          context.showLoading();
        }

        if (state is UserCancelled || state is AuthenticationFailed) {
          context.dismissLoading();
          context.showToast(
              type: ToastType.errorToast,
              title: HatSpaceStrings.current.signinErrorToastTitle,
              message: HatSpaceStrings.current.signinErrorToastMessage);
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextOnlyButton(
                                  label: HatSpaceStrings.current.skip
                                      .toUpperCase(),
                                  onPressed: () {
                                    context
                                        .read<AuthenticationBloc>()
                                        .add(SkipSignUp());
                                    context.pop();
                                  },
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                      colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ]),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: HsDimens.spacing80),
                            child: SvgPicture.asset(Assets.images.logo,
                                width: HsDimens.size118,
                                height: HsDimens.size64),
                          ),
                        ]),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: HsDimens.spacing24,
                              vertical: HsDimens.spacing16),
                          child: SecondaryButton(
                            contentAlignment: MainAxisAlignment.start,
                            label: HatSpaceStrings.current.facebookSignUp,
                            iconUrl: Assets.icons.facebook,
                            overrideIconColor: false,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      const EdgeInsets.all(HsDimens.spacing16)),
                            ),
                            onPressed: () {
                              context
                                  .read<SignUpBloc>()
                                  .add(const SignUpWithFacebook());
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: HsDimens.spacing24,
                              right: HsDimens.spacing24,
                              bottom: HsDimens.spacing16),
                          child: SecondaryButton(
                            contentAlignment: MainAxisAlignment.start,
                            label: HatSpaceStrings.current.googleSignUp,
                            iconUrl: Assets.icons.google,
                            overrideIconColor: false,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      const EdgeInsets.all(HsDimens.spacing16)),
                            ),
                            onPressed: () {
                              context
                                  .read<SignUpBloc>()
                                  .add(const SignUpWithGoogle());
                            },
                          )),
                      if (defaultTargetPlatform == TargetPlatform.iOS) ...[
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: HsDimens.spacing24),
                            child: SecondaryButton(
                              contentAlignment: MainAxisAlignment.start,
                              label: HatSpaceStrings.current.appleSignUp,
                              iconUrl: Assets.icons.apple,
                              overrideIconColor: false,
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                    const EdgeInsets.all(HsDimens.spacing16)),
                              ),
                              onPressed: () {
                                /// TODO : Handle login by apple
                              },
                            )),
                      ],
                    ],
                  ))
                ])),
          ],
        ),
      ),
    );
  }
}
