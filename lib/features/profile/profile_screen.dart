import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/data/data.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/profile/view_model/get_user_detail_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetUserDetailCubit>(
      create: (_) => GetUserDetailCubit()..getUserInformation(),
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
        Padding(
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
                child: BlocBuilder<GetUserDetailCubit, GetUserDetailState>(
                    buildWhen: (_, current) {
                  return current is GetUserDetailSucceedState ||
                      current is GetUserDetailFailedState;
                }, builder: (_, state) {
                  if (state is GetUserDetailSucceedState &&
                      state.user.avatar != null &&
                      state.user.avatar!.isNotEmpty) {
                    return Image.network(state.user.avatar!, fit: BoxFit.cover);
                  }
                  return SvgPicture.asset(Assets.images.userDefaultAvatar,
                      fit: BoxFit.none);
                }),
              ),
              const SizedBox(width: HsDimens.spacing16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<GetUserDetailCubit, GetUserDetailState>(
                        buildWhen: (_, current) {
                      return current is GetUserDetailSucceedState ||
                          current is GetUserDetailFailedState;
                    }, builder: (_, state) {
                      String name = '';
                      if (state is GetUserDetailSucceedState) {
                        name = state.user.displayName ?? '';
                      }
                      return Text(name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontStyleGuide.fwBold,
                                  fontSize: FontStyleGuide.fontSize16));
                    }),
                    const SizedBox(height: HsDimens.spacing4),
                    Text(HatSpaceStrings.current.viewProfile,
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: HsDimens.spacing6),
                    BlocBuilder<GetUserDetailCubit, GetUserDetailState>(
                        buildWhen: (previous, current) {
                      return current is GetUserRolesSucceedState ||
                          current is GetUserRolesFailedState;
                    }, builder: (_, state) {
                      if (state is GetUserRolesSucceedState) {
                        return Wrap(
                          spacing: HsDimens.spacing4,
                          runSpacing: HsDimens.spacing4,
                          children: state.roles
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
                                            ?.copyWith(
                                                color: HSColor.neutral1)),
                                  ))
                              .toList(),
                        );
                      }
                      return const SizedBox();
                    }),
                  ],
                ),
              ),
              const SizedBox(width: HsDimens.spacing12),
              SvgPicture.asset(Assets.icons.arrowRight)
            ],
          ),
        ),
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
                onPressed: () {},
              ),
              const SizedBox(height: HsDimens.spacing24),
            ],
          ),
        )
      ])),
    ));
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
    return Row(
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
              SvgPicture.asset(Assets.icons.arrowRight),
            ],
          ),
        ))
      ],
    );
  }
}
