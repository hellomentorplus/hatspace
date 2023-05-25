import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/features/add_property/view/add_property_page_view.dart';
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
                          iconUrl: Assets.images.google,
                          onPressed: () {
                            context
                                .read<SignUpBloc>()
                                .add(const SignUpWithGoogle());
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SecondaryButton(
                          label: HatSpaceStrings.of(context).facebookSignUp,
                          iconUrl: Assets.images.facebookround,
                          onPressed: () {
                            context
                                .read<SignUpBloc>()
                                .add(const SignUpWithFacebook());
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: SecondaryButton(
                          label: HatSpaceStrings.of(context).emailSignUp,
                          iconUrl: Assets.images.envelope,
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
                                        ..onTapDown = (details) {})
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
