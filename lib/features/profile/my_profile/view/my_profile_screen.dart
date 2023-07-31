import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/profile/my_profile/view_model/my_profile_cubit.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyProfileCubit()..getUserInformation(),
      child: const MyProfileBody(),
    );
  }
}

class MyProfileBody extends StatelessWidget {
  const MyProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(HatSpaceStrings.current.myProfile,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontStyleGuide.fwBold)),
            actions: [
              IconButton(
                  padding: const EdgeInsets.only(right: HsDimens.spacing8),
                  onPressed: () {
                    /// TODO : Handle edit button press
                  },
                  icon: Text(HatSpaceStrings.current.edit,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontStyleGuide.fwBold,
                          color: HSColor.primary))),
            ],
            backgroundColor: HSColor.neutral1,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: SvgPicture.asset(Assets.icons.arrowCalendarLeft),
            ),
            elevation: 0,
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                  color: HSColor.neutral2,
                  height: 1.0,
                )),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: HsDimens.spacing16),
              child: Column(
                children: [
                  const SizedBox(height: HsDimens.spacing32),
                  Stack(
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: HSColor.neutral2,
                          ),
                          clipBehavior: Clip.hardEdge,
                          height: HsDimens.size104,
                          width: HsDimens.size104,
                          child:
                              BlocSelector<MyProfileCubit, MyProfileState, String?>(
                            selector: (state) {
                              if (state is GetUserInformationSucceedState) {
                                return state.user.avatar;
                              }
                              return '';
                            },
                            builder: (context, avatar) {
                              return avatar != null && avatar.isNotEmpty
                                  ? Image.network(
                                      avatar,
                                      fit: BoxFit.cover,
                                    )
                                  : SvgPicture.asset(
                                      Assets.images.userDefaultAvatar,
                                      fit: BoxFit.none,
                                    );
                            },
                          )),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: SvgPicture.asset(Assets.images.cameraCircle))
                    ],
                  ),
                  const SizedBox(height: HsDimens.spacing32),
                  BlocSelector<MyProfileCubit, MyProfileState, String>(
                    selector: (state) {
                      if (state is GetUserInformationSucceedState) {
                        return state.user.displayName ?? '';
                      }
                      return '';
                    },
                    builder: (context, displayName) {
                      return _InformationView(
                        title: HatSpaceStrings.current.displayName,
                        value: displayName,
                      );
                    }
                  ),
                  BlocSelector<MyProfileCubit, MyProfileState, String>(
                    selector: (state) {
                      return '';
                    },
                    builder: (context, fullName) {
                      return _InformationView(
                        title: HatSpaceStrings.current.fullName,
                        value: fullName,
                      );
                    }
                  ),
                  BlocSelector<MyProfileCubit, MyProfileState, String>(
                    selector: (state) {
                      if (state is GetUserInformationSucceedState) {
                        return state.user.email ?? '';
                      }
                      return '';
                    },
                    builder: (context, email) {
                      return _InformationView(
                        title: HatSpaceStrings.current.email,
                        value: email,
                      );
                    }
                  ),
                  BlocSelector<MyProfileCubit, MyProfileState, String>(
                    selector: (state) {
                      if (state is GetUserInformationSucceedState) {
                        return state.user.phone ?? '';
                      }
                      return '';
                    }, builder: (context, phone) {
                      return _InformationView(
                        title: HatSpaceStrings.current.phoneNumber,
                        value: phone,
                      );
                    }),
                  BlocSelector<MyProfileCubit, MyProfileState, String>(
                    selector: (state) {
                      return '';
                    }, 
                    builder: (context, birth) {
                      return _InformationView(
                        title: HatSpaceStrings.current.dateOfBirth,
                        value: birth,
                      );
                    }),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

class _InformationView extends StatelessWidget {
  final String title;
  final String? value;
  const _InformationView({required this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: HsDimens.spacing12),
        Text(title,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: HSColor.neutral6)),
        const SizedBox(height: HsDimens.spacing4),
        if (value != null && value!.isNotEmpty)...[
          Text(value!,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w500)),
        ] else ...[
          Text(HatSpaceStrings.current.notUpdated,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w500, color: HSColor.neutral5)),
        ],
        const SizedBox(height: HsDimens.spacing12),
        const Divider(color: HSColor.neutral2, thickness: 1, height: 1)
      ],
    );
  }
}
