import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/dimens/hs_dimens.dart';
import 'package:hatspace/features/home/view/widgets/app_bar_bottom.dart';
import 'package:hatspace/features/home/view/widgets/property_item_view.dart';
import 'package:hatspace/features/home/view_model/get_properties_cubit.dart';
import 'package:hatspace/features/home/view_model/home_interaction_cubit.dart';
import 'package:hatspace/theme/extensions/bottom_modal_extension.dart';
import 'package:hatspace/theme/widgets/hs_warning_bottom_sheet.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/view_models/app_config/bloc/app_config_bloc.dart';
import 'package:shake/shake.dart';

import 'package:hatspace/view_models/authentication/authentication_bloc.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeInteractionCubit>(
          create: (context) => HomeInteractionCubit(),
        ),
        BlocProvider<GetPropertiesCubit>(
          create: (context) => GetPropertiesCubit()..getProperties(),
        ),
      ],
      child: const HomePageBody(),
    );
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => HomePageBodyState();
}

class HomePageBodyState extends State<HomePageBody> {
  late ShakeDetector detector;

  @override
  void dispose() {
    try {
      detector.stopListening();
    } catch (e) {
      // do nothing
    }
    super.dispose();
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

  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  Future<void> showAddRoleModal(BuildContext context) {
    HsWarningBottomSheetView addRoleModal = HsWarningBottomSheetView(
        iconUrl: Assets.images.landlordCircle,
        title: HatSpaceStrings.current.addHomeownerRole,
        description: HatSpaceStrings.current.addHomeownerRoleDescription,
        primaryButtonLabel: HatSpaceStrings.current.addHomeownerRole,
        primaryOnPressed: () {
          context.pop();
          context.read<HomeInteractionCubit>().goToAddProperty();
        },
        secondaryButtonLabel: HatSpaceStrings.current.later,
        secondaryOnPressed: () {
          context.pop();
        });
    return context.showHsBottomSheet(addRoleModal);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<AppConfigBloc, AppConfigState>(
              listener: (context, state) {
            if (state is DebugOptionEnabledState &&
                state.debugOptionEnabled == true) {
              onShakeToAction(context, state);
            }
          }),
          BlocListener<HomeInteractionCubit, HomeInteractionState>(
            listener: (context, state) {
              if (state is StartAddPropertyFlow) {
                context.goToAddProperty();
              }

              if (state is ShowAddRoleModal) {
                showAddRoleModal(context).then((value) {
                  context.read<HomeInteractionCubit>().onCloseModal();
                });
              }
            },
          )
        ],
        child: Scaffold(
            appBar: AppBar(
              title: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  String? welcome = (state is AuthenticatedState)
                      ? HatSpaceStrings.current
                          .welcomeName(state.userDetail.displayName ?? '')
                      : HatSpaceStrings.current.welcomeDefault;

                  return Text(
                    welcome.trim(), // trim text in case display name is null
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: colorScheme.onPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
              titleSpacing: HsDimens.spacing16,
              centerTitle: false,
              backgroundColor: Theme.of(context).colorScheme.primary,
              bottom: SearchBar(),
              toolbarHeight: 40,
              elevation: 0.0,
              actions: [
                IconButton(
                    onPressed: () {
                      // TODO add action
                    },
                    icon: SvgPicture.asset(
                      Assets.icons.icAgent,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.onPrimary,
                          BlendMode.srcIn),
                      width: HsDimens.size24,
                      height: HsDimens.size24,
                    )),
                IconButton(
                  onPressed: () {
                    // TODO add action
                  },
                  icon: SvgPicture.asset(
                    Assets.icons.notification,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onPrimary,
                        BlendMode.srcIn),
                    width: HsDimens.size24,
                    height: HsDimens.size24,
                  ),
                )
              ],
            ),
            body: BlocBuilder<GetPropertiesCubit, GetPropertiesState>(
              builder: (context, state) {
                if (state is GetPropertiesSucceedState) {
                  if (state.propertyList.isNotEmpty) {
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: HsDimens.spacing16,
                        vertical: HsDimens.spacing24,
                      ),
                      itemBuilder: (_, idx) => PropertyItemView(
                          key: ValueKey(state.propertyList[idx].id),
                          property: state.propertyList[idx]),
                      itemCount: state.propertyList.length,
                      separatorBuilder: (_, __) => const SizedBox(
                        height: HsDimens.spacing12,
                      ),
                    );
                  }

                  /// TODO :  Render empty data widget
                } else if (state is GetPropertiesFailedState) {
                  /// TODO :  Render failed widget
                } else if (state is GettingPropertiesState) {
                  /// TODO :  Render loading widget
                }
                return const SizedBox();
              },
            ),
            bottomNavigationBar: BottomAppBar(
                color: HSColor.neutral1.withOpacity(0.9),
                child: SafeArea(
                  child: SizedBox(
                    height: HsDimens.size66,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ValueListenableBuilder<int>(
                          valueListenable: _selectedIndex,
                          builder: (context, value, child) => _BottomBarItem(
                            icon: Assets.icons.explore,
                            label: HatSpaceStrings.current.explore,
                            isSelected: value == 0,
                            onTap: () => _selectedIndex.value = 0,
                          ),
                        ),
                        ValueListenableBuilder<int>(
                          valueListenable: _selectedIndex,
                          builder: (context, value, child) => _BottomBarItem(
                            icon: Assets.icons.booking,
                            label: HatSpaceStrings.current.booking,
                            isSelected: value == 1,
                            onTap: () => _selectedIndex.value = 1,
                          ),
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
                                      .read<HomeInteractionCubit>()
                                      .onBottomItemTapped(BottomBarItems.addingProperty);
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
                        ValueListenableBuilder<int>(
                          valueListenable: _selectedIndex,
                          builder: (context, value, child) => _BottomBarItem(
                            icon: Assets.icons.message,
                            label: HatSpaceStrings.current.message,
                            isSelected: value == 2,
                            onTap: () => _selectedIndex.value = 2,
                          ),
                        ),
                        ValueListenableBuilder<int>(
                          valueListenable: _selectedIndex,
                          builder: (context, value, child) => _BottomBarItem(
                            icon: Assets.icons.profile,
                            label: HatSpaceStrings.current.profile,
                            isSelected: value == 3,
                            onTap: () => _selectedIndex.value = 3,
                          ),
                        )
                      ],
                    ),
                  ),
                ))));
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
                      color: isSelected ? HSColor.green06 : HSColor.neutral6))
            ],
          ),
        ),
      );
}
