import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/application/view_model/application_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_buttons.dart';
import 'package:hatspace/theme/widgets/hs_buttons_settings.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplicationView extends StatelessWidget {
  const ApplicationView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<ApplicationCubit>(
      create: (context) => ApplicationCubit(), child: const _ApplicationView());
}

class _ApplicationView extends StatelessWidget {
  const _ApplicationView();

  @override
  Widget build(BuildContext context) =>
      BlocListener<ApplicationCubit, ApplicationState>(
        listener: (context, state) {
          if (state is DownloadFileStart) {}

          if (state is DownloadFileInProgress) {}

          if (state is DownloadFileCompleted) {
            launchUrl(Uri.file(state.path));
          }

          if (state is DownloadFileCancel) {}

          if (state is DownloadFileError) {}

          if (state is DownloadFilePaused) {}
        },
        child: Scaffold(
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: HsDimens.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: HsDimens.spacing24),
                SafeArea(
                  child: Text(HatSpaceStrings.current.guideForApplication,
                      style: Theme.of(context).textTheme.displayLarge),
                ),
                const SizedBox(height: HsDimens.spacing24),
                Container(
                  padding: const EdgeInsets.all(HsDimens.spacing12),
                  decoration: BoxDecoration(
                      color: HSColor.blue01,
                      borderRadius: BorderRadius.circular(HsDimens.radius8)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(Assets.icons.information),
                      const SizedBox(width: HsDimens.spacing12),
                      Expanded(
                          child: Text(HatSpaceStrings.current.applicationInform,
                              style: Theme.of(context).textTheme.bodyMedium)),
                    ],
                  ),
                ),
                const SizedBox(height: HsDimens.spacing24),
                Text(HatSpaceStrings.current.applicationRequirementsAsking,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontStyleGuide.fwBold)),
                const SizedBox(height: HsDimens.spacing8),
                _ApplicationRequirementView(
                  iconPath: Assets.icons.identification,
                  title: HatSpaceStrings.current.applicationIdentification,
                ),
                const SizedBox(height: HsDimens.spacing12),
                _ApplicationRequirementView(
                  iconPath: Assets.icons.tenancyReference,
                  title: HatSpaceStrings.current.applicationReference,
                ),
                const SizedBox(height: HsDimens.spacing12),
                _ApplicationRequirementView(
                  iconPath: Assets.icons.paySlips,
                  title: HatSpaceStrings.current.applicationPaySlips,
                ),
                const SizedBox(height: HsDimens.spacing12),
                _ApplicationRequirementView(
                  iconPath: Assets.icons.bankStatement,
                  title: HatSpaceStrings.current.applicationBankStatement,
                ),
                const SizedBox(height: HsDimens.spacing20),
                Text(HatSpaceStrings.current.downloadApplicationFormHere,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontStyleGuide.fwBold)),
                const SizedBox(height: HsDimens.spacing20),
                SecondaryButton(
                  label: HatSpaceStrings.current.download,
                  iconUrl: Assets.icons.download,
                  onPressed: () {
                    context.read<ApplicationCubit>().downloadApplicationForm();
                  },
                ),
                const SizedBox(height: HsDimens.spacing20),
                Text(HatSpaceStrings.current.questionSupport,
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: HsDimens.spacing24),
                Row(
                  children: [
                    Expanded(
                        child: SecondaryButton(
                      label: HatSpaceStrings.current.contactSupport,
                      onPressed: () {
                        launchUrl(Uri.parse(
                            'tel:${HatSpaceStrings.current.applicationContactNumber}'));
                      },
                    )),
                    const SizedBox(width: HsDimens.spacing16),
                    Expanded(
                        child: PrimaryButton(
                      label: HatSpaceStrings.current.sendEmail,
                      iconUrl: Assets.icons.emailWhite,
                      iconPosition: IconPosition.right,
                      onPressed: () {
                        launchUrl(Uri.parse(
                            'mailto:${HatSpaceStrings.current.applicationEmail}?subject=${HatSpaceStrings.current.applicationSubject}'));
                      },
                    ))
                  ],
                ),
                const SizedBox(height: HsDimens.spacing16),
              ],
            ),
          )),
        ),
      );
}

class _ApplicationRequirementView extends StatelessWidget {
  final String iconPath;
  final String title;
  const _ApplicationRequirementView(
      {required this.iconPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: HsDimens.size42,
          height: HsDimens.size42,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(HsDimens.radius8),
              color: HSColor.green01),
          child: SvgPicture.asset(iconPath, fit: BoxFit.none),
        ),
        const SizedBox(width: HsDimens.spacing12),
        Expanded(
            child: Text(title, style: Theme.of(context).textTheme.bodyMedium))
      ],
    );
  }
}
