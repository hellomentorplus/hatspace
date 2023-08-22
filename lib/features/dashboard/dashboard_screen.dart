import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatspace/features/application/application_view.dart';
import 'package:hatspace/features/dashboard/view_model/add_home_owner_role_cubit.dart';
import 'package:hatspace/features/dashboard/view_model/dashboard_interaction_cubit.dart';
import 'package:hatspace/features/inspection/inspection_view.dart';
import 'package:hatspace/features/profile/view/profile_view.dart';
import 'package:hatspace/features/home/view/home_view.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/theme/extensions/bottom_modal_extension.dart';
import 'package:hatspace/view_models/authentication/authentication_bloc.dart';
import 'package:shake/shake.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/theme/widgets/hs_warning_bottom_sheet.dart';
import 'package:hatspace/view_models/app_config/bloc/app_config_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<DashboardInteractionCubit>(
        create: (context) => DashboardInteractionCubit(),
      ),
      BlocProvider<AddHomeOwnerRoleCubit>(
        create: (context) => AddHomeOwnerRoleCubit(),
      )
    ], child: const DashboardBody());
  }
}

class DashboardBody extends StatefulWidget {
  const DashboardBody({Key? key}) : super(key: key);

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody>
    with WidgetsBindingObserver {
  late ShakeDetector detector;
  final ValueNotifier<BottomBarItems> _selectedIndex =
      ValueNotifier<BottomBarItems>(BottomBarItems.explore);

  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    try {
      detector.stopListening();
    } catch (e) {
      // do nothing
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<DashboardInteractionCubit>().onScreenResumed();
    }
  }

  void onShakeToAction(BuildContext context, AppConfigState state) {
    // Only listen ShakeDetector when debugOptionTrue
    detector = ShakeDetector.waitForStart(
        onPhoneShake: () async {
          // To limit that shaking will happen more than one so there will be multiple push happened
          if (detector.mShakeCount == 1) {
            context.goToWidgetCatalog();
          }
        },
        shakeSlopTimeMS: 1000);
    detector.startListening();
  }

  Future<void> showLoginModal(BuildContext context) {
    HsWarningBottomSheetView loginModal = HsWarningBottomSheetView(
        iconUrl: Assets.images.loginCircle,
        title: HatSpaceStrings.current.login,
        description: HatSpaceStrings.current.loginDescription,
        primaryButtonLabel: HatSpaceStrings.current.yesLoginNow,
        primaryOnPressed: () {
          context.pop();
          context.read<DashboardInteractionCubit>().goToSignUpScreen();
        },
        secondaryButtonLabel: HatSpaceStrings.current.noLater,
        secondaryOnPressed: () {
          context.pop();
        });
    return context.showHsBottomSheet(loginModal);
  }

  Future<void> showRequestHomeOwnerRoleBottomSheet() {
    return context
        .showHsBottomSheet(HsWarningBottomSheetView(
      iconUrl: Assets.icons.requestHomeownerRole,
      title: HatSpaceStrings.current.addHomeOwnerRoleTitle,
      description: HatSpaceStrings.current.addHomeOwnerRoleContent,
      primaryButtonLabel: HatSpaceStrings.current.addHomeOwnerPrimaryBtnLabel,
      primaryOnPressed: () {
        context.read<AddHomeOwnerRoleCubit>().addHomeOwnerRole();
      },
      secondaryButtonLabel:
          HatSpaceStrings.current.addHomeOwnerSecondaryBtnLabel,
      secondaryOnPressed: () {
        context.dismissHsBottomSheet();
      },
    ))
        .then((value) {
      context.read<DashboardInteractionCubit>().onCloseRequestHomeOwnerModal();
    });
  }

  Future<void> _showPhotoPermissionBottomSheet() {
    return context
        .showHsBottomSheet<void>(HsWarningBottomSheetView(
      title: HatSpaceStrings.current.hatSpaceWouldLikeToPhotoAccess,
      description:
          HatSpaceStrings.current.plsGoToSettingsAndAllowPhotoAccessForHatSpace,
      iconUrl: Assets.icons.photoAccess,
      primaryButtonLabel: HatSpaceStrings.current.goToSetting,
      primaryOnPressed: () {
        context.read<DashboardInteractionCubit>().gotoSetting();
        context.pop();
      },
      secondaryButtonLabel: HatSpaceStrings.current.cancelBtn,
      secondaryOnPressed: () {
        context.read<DashboardInteractionCubit>().cancelPhotoAccess();
        context.dismissHsBottomSheet();
      },
    ))
        .then((value) {
      context.read<DashboardInteractionCubit>().onDismissModal();
    });
  }

  @override
  Widget build(BuildContext buildContext) => MultiBlocListener(
        listeners: [
          BlocListener<AppConfigBloc, AppConfigState>(
              listener: (context, state) {
            if (state is DebugOptionEnabledState &&
                state.debugOptionEnabled == true) {
              onShakeToAction(context, state);
            }
          }),
          BlocListener<DashboardInteractionCubit, DashboardInteractionState>(
            listener: (context, state) {
              if (state is OpenLoginBottomSheetModal) {
                showLoginModal(context).then((value) {
                  context.read<DashboardInteractionCubit>().onCloseLoginModal();
                });
              }
              if (state is GotoSignUpScreen) {
                context.goToSignup().then((isLoginFromLoginModal) {
                  if (isLoginFromLoginModal == true) {
                    context
                        .read<DashboardInteractionCubit>()
                        .navigateToExpectedScreen();
                  }
                });
              }

              if (state is RequestHomeOwnerRole) {
                if (ModalRoute.of(context)?.isCurrent == true) {
                  showRequestHomeOwnerRoleBottomSheet();
                }
              }

              if (state is PhotoPermissionGranted) {
                context.goToAddProperty();
                context
                    .read<DashboardInteractionCubit>()
                    .onNavigateToAddPropertyFlow();
              }

              if (state is PhotoPermissionDenied) {
                // do nothing
              }

              if (state is PhotoPermissionDeniedForever) {
                _showPhotoPermissionBottomSheet();
              }

              if (state is OpenPage) {
                _animateToPage(state.item.pageIndex);
                _selectedIndex.value = state.item;
              }
            },
          ),
          BlocListener<AddHomeOwnerRoleCubit, AddHomeOwnerRoleState>(
            listener: (context, state) {
              if (state is AddHomeOwnerRoleSucceeded) {
                // check current state is RequestHomeOwnerRole
                final homeInteractionState =
                    context.read<DashboardInteractionCubit>().state;
                if (homeInteractionState is RequestHomeOwnerRole) {
                  context.pop();
                  context
                      .read<DashboardInteractionCubit>()
                      .onBottomItemTapped(BottomBarItems.addingProperty);
                }
              }
            },
          ),
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AnonymousState) {
                context
                    .read<DashboardInteractionCubit>()
                    .onBottomItemTapped(BottomBarItems.explore);
              }
            },
          )
        ],
        child: Scaffold(
            body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                HomePageView(),
                InspectionView(),
                ApplicationView(),
                ProfileView()
              ],
            ),
            bottomNavigationBar: BottomAppBar(
                color: HSColor.neutral1.withOpacity(0.9),
                child: SafeArea(
                  child: SizedBox(
                    height: HsDimens.size66,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ValueListenableBuilder<BottomBarItems>(
                          valueListenable: _selectedIndex,
                          builder: (context, value, child) => _BottomBarItem(
                              icon: Assets.icons.explore,
                              label: HatSpaceStrings.current.explore,
                              isSelected: value == BottomBarItems.explore,
                              onTap: () {
                                context
                                    .read<DashboardInteractionCubit>()
                                    .onBottomItemTapped(BottomBarItems.explore);
                              }),
                        ),
                        ValueListenableBuilder<BottomBarItems>(
                          valueListenable: _selectedIndex,
                          builder: (context, value, child) => _BottomBarItem(
                              icon: Assets.icons.booking,
                              label: HatSpaceStrings.current.inspection,
                              isSelected: value == BottomBarItems.inspection,
                              onTap: () {
                                context
                                    .read<DashboardInteractionCubit>()
                                    .onBottomItemTapped(
                                        BottomBarItems.inspection);
                              }),
                        ),
                        Container(
                          decoration: ShapeDecoration(
                            shape: const CircleBorder(),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          width: HsDimens.size48,
                          height: HsDimens.size48,
                          margin: const EdgeInsets.all(HsDimens.spacing8),
                          child: Material(
                            color: Colors.transparent,
                            child: Builder(builder: (context) {
                              return InkWell(
                                borderRadius:
                                    BorderRadius.circular(HsDimens.radius48),
                                onTap: () {
                                  context
                                      .read<DashboardInteractionCubit>()
                                      .onBottomItemTapped(
                                          BottomBarItems.addingProperty);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.all(HsDimens.spacing12),
                                  child: SvgPicture.asset(
                                    Assets.icons.add,
                                    width: HsDimens.size24,
                                    height: HsDimens.size24,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        ValueListenableBuilder<BottomBarItems>(
                          valueListenable: _selectedIndex,
                          builder: (context, value, child) => _BottomBarItem(
                              icon: Assets.icons.application,
                              label: HatSpaceStrings.current.application,
                              isSelected: value == BottomBarItems.application,
                              onTap: () {
                                context
                                    .read<DashboardInteractionCubit>()
                                    .onBottomItemTapped(
                                        BottomBarItems.application);
                              }),
                        ),
                        ValueListenableBuilder<BottomBarItems>(
                          valueListenable: _selectedIndex,
                          builder: (context, value, child) => _BottomBarItem(
                              icon: Assets.icons.profile,
                              label: HatSpaceStrings.current.profile,
                              isSelected: value == BottomBarItems.profile,
                              onTap: () {
                                context
                                    .read<DashboardInteractionCubit>()
                                    .onBottomItemTapped(BottomBarItems.profile);
                              }),
                        )
                      ],
                    ),
                  ),
                ))),
      );

  void _animateToPage(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }
}

class _BottomBarItem extends StatelessWidget {
  /// Need SVG asset path here
  final String icon;

  /// Label to be display below SVG Icon
  final String label;

  /// is this item selected?
  final bool isSelected;

  /// ontap action
  final VoidCallback onTap;

  const _BottomBarItem(
      {required this.icon,
      required this.label,
      required this.isSelected,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(HsDimens.radius66),
        child: AspectRatio(
          aspectRatio: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                width: HsDimens.size24,
                height: HsDimens.size24,
                colorFilter: ColorFilter.mode(
                    isSelected
                        ? Theme.of(context).colorScheme.primary
                        : HSColor.neutral6,
                    BlendMode.srcIn),
              ),
              Text(label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isSelected ? HSColor.green06 : HSColor.neutral6,
                      fontSize: FontStyleGuide.fontSize10))
            ],
          ),
        ),
      );
}
