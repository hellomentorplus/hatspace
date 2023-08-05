import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/profile/my_profile/view/my_profile_screen.dart';
import 'package:hatspace/features/profile/view_model/profile_cubit.dart';
import 'package:hatspace/features/sign_up/view/sign_up_screen.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/extensions/bottom_modal_extension.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_warning_bottom_sheet.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (_) => ProfileCubit()..getUserInformation(),
      child: const ProfileBody(),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      bottom: false,
      child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: HsDimens.spacing24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: HsDimens.spacing16),
          child: Text(HatSpaceStrings.current.profile,
              style: Theme.of(context).textTheme.displayLarge),
        ),
        const SizedBox(height: HsDimens.spacing20),
        BlocConsumer<ProfileCubit, ProfileState>(listener: (_, state) {
          if (state is DeleteAccountSucceedState) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const SignUpScreen()));
          }
        }, builder: (_, state) {
          if (state is DeleteAccountSucceedState) {
            return const SizedBox();
          }
          return const _UserInformationView();
        }),
        const SizedBox(height: HsDimens.spacing24),
        Padding(
          padding: const EdgeInsets.only(
              left: HsDimens.spacing16, right: HsDimens.spacing8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(HatSpaceStrings.current.myAccount,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: FontStyleGuide.fontSize18)),
              const SizedBox(height: HsDimens.spacing8),
              _OptionView(
                iconPath: Assets.icons.apartment,
                title: HatSpaceStrings.current.myProperties,
                onPressed: () {},
              ),
              _OptionView(
                iconPath: Assets.icons.favorite,
                title: HatSpaceStrings.current.favoriteLists,
                onPressed: () {},
              ),
              const SizedBox(height: HsDimens.spacing24),
              Text(HatSpaceStrings.current.settings,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: FontStyleGuide.fontSize18)),
              const SizedBox(height: HsDimens.spacing8),
              _OptionView(
                iconPath: Assets.icons.language,
                title: HatSpaceStrings.current.language,
                suffixText: 'English',
                onPressed: () {},
              ),
              _OptionView(
                iconPath: Assets.icons.info,
                title: HatSpaceStrings.current.otherInformation,
                onPressed: () {},
              ),
              _OptionView(
                iconPath: Assets.icons.logout,
                title: HatSpaceStrings.current.logOut,
                onPressed: () {},
              ),
              _OptionView(
                iconPath: Assets.icons.delete,
                title: HatSpaceStrings.current.deleteAccount,
                onPressed: () => _showDeleteAccountBottomSheet(context),
              ),
              const SizedBox(height: HsDimens.spacing24),
            ],
          ),
        )
      ])),
    ));
  }

  Future<void> _showDeleteAccountBottomSheet(BuildContext context) {
    HsWarningBottomSheetView deleteBottomSheet = HsWarningBottomSheetView(
        iconUrl: Assets.images.circleWarning,
        title: HatSpaceStrings.current.deleteAccountQuestionMark,
        description: HatSpaceStrings.current.deleteAccountWarning,
        primaryButtonLabel: HatSpaceStrings.current.cancelBtn,
        primaryOnPressed: () {
          context.pop();
        },
        secondaryButtonLabel: HatSpaceStrings.current.submit,
        secondaryButtonStyle:
            OutlinedButton.styleFrom(foregroundColor: HSColor.red06),
        secondaryOnPressed: () {
          context.read<ProfileCubit>().deleteAccount();
          context.pop();
        });
    return context.showHsBottomSheet(deleteBottomSheet);
  }
}

class _UserInformationView extends StatelessWidget {
  const _UserInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const MyProfileScreen())),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: HsDimens.spacing16),
        child: Row(
          children: [
            Container(
                width: HsDimens.size64,
                height: HsDimens.size64,
                decoration: BoxDecoration(
                    color: HSColor.neutral2,
                    borderRadius: BorderRadius.circular(HsDimens.size64)),
                clipBehavior: Clip.hardEdge,
                child: BlocSelector<ProfileCubit, ProfileState, String?>(
                  selector: (state) {
                    if (state is GetUserDetailSucceedState &&
                        state.user.avatar != null &&
                        state.user.avatar!.isNotEmpty) {
                      return state.user.avatar;
                    }

                    return null;
                  },
                  builder: (context, state) {
                    return state != null
                        ? Image.network(
                            state,
                            fit: BoxFit.cover,
                          )
                        : SvgPicture.asset(
                            Assets.images.userDefaultAvatar,
                            fit: BoxFit.none,
                          );
                  },
                )),
            const SizedBox(width: HsDimens.spacing16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocSelector<ProfileCubit, ProfileState, String>(
                      selector: (state) {
                    if (state is GetUserDetailSucceedState) {
                      return state.user.displayName ?? '';
                    }

                    return '';
                  }, builder: (_, name) {
                    return Text(name,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontStyleGuide.fwBold,
                            fontSize: FontStyleGuide.fontSize16));
                  }),
                  const SizedBox(height: HsDimens.spacing4),
                  Text(HatSpaceStrings.current.viewProfile,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: HsDimens.spacing6),
                  BlocSelector<ProfileCubit, ProfileState, List<Roles>>(
                      selector: (state) {
                    if (state is GetUserDetailSucceedState) {
                      return state.roles;
                    }

                    return [];
                  }, builder: (_, roles) {
                    return Wrap(
                      spacing: HsDimens.spacing4,
                      runSpacing: HsDimens.spacing4,
                      children: roles
                          .map((role) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: HsDimens.spacing8,
                                  vertical: HsDimens.spacing4,
                                ),
                                decoration: ShapeDecoration(
                                  shape: const StadiumBorder(),
                                  color: (() {
                                    switch (role) {
                                      case Roles.tenant:
                                        return HSColor.blue05;
                                      case Roles.homeowner:
                                        return HSColor.orange05;
                                    }
                                  }()),
                                ),
                                child: Text(role.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: HSColor.neutral1)),
                              ))
                          .toList(),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(width: HsDimens.spacing12),
            SvgPicture.asset(Assets.icons.chevronRight)
          ],
        ),
      ),
    );
  }
}

class _OptionView extends StatelessWidget {
  final String iconPath;
  final String title;
  final String? suffixText;
  final VoidCallback onPressed;
  const _OptionView(
      {required this.iconPath,
      required this.title,
      required this.onPressed,
      this.suffixText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          SvgPicture.asset(iconPath),
          const SizedBox(width: HsDimens.spacing16),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(vertical: HsDimens.spacing16),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: HSColor.neutral2))),
            child: Row(
              children: [
                Expanded(
                    child: Text(title,
                        style: Theme.of(context).textTheme.bodyMedium)),
                if (suffixText != null && suffixText!.isNotEmpty) ...[
                  const SizedBox(width: HsDimens.spacing8),
                  Text(suffixText!,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(width: HsDimens.spacing8)
                ],
                SvgPicture.asset(Assets.icons.chevronRight),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
