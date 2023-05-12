import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hatspace/features/home/view/widgets/app_bar_bottom.dart';
import 'package:hatspace/gen/assets.gen.dart';
import 'package:hatspace/route/router.dart';
import 'package:hatspace/strings/l10n.dart';
import 'package:hatspace/theme/hs_theme.dart';
import 'package:hatspace/view_models/app_config/bloc/app_config_bloc.dart';
import 'package:shake/shake.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => HomePageViewState();
}

class HomePageViewState extends State<HomePageView> {
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
          // To limit that shaking will happend more than one so there will be muliple push happened
          if (detector.mShakeCount == 1) {
            context.goToWidgetCatalog();
          }
        },
        shakeSlopTimeMS: 1000);
    detector.startListening();
  }

  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppConfigBloc, AppConfigState>(
        listener: (context, state) {
          if (state is DebugOptionEnabledState &&
              state.debugOptionEnabled == true) {
            onShakeToAction(context, state);
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Hi Hoang Nguyen', // TODO load user display name to be used here
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(color: colorScheme.onPrimary),
              ),
              titleSpacing: 16.0,
              centerTitle: false,
              backgroundColor: Theme.of(context).colorScheme.primary,
              bottom: const SearchBar(),
              toolbarHeight: 40,
              elevation: 0.0,
              actions: [
                IconButton(
                  onPressed: () {
                    // TODO add action
                  },
                  icon: SvgPicture.asset(
                    Assets.icons.notification,
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 24,
                    height: 24,
                  ),
                )
              ],
            ),
            body: Center(
                child: Text(
              HatSpaceStrings.of(context).homePageViewTitle,
            )),
            bottomNavigationBar: BottomAppBar(
              color: HSColor.neutral2,
              height: 66 + MediaQuery.of(context).padding.bottom,
              child: SafeArea(
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
                      width: 48,
                      height: 48,
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        Assets.icons.add,
                        width: 24,
                        height: 24,
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
            )));
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
        borderRadius: BorderRadius.circular(36.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                width: 24,
                height: 24,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : HSColor.neutral6,
              ),
              Text(label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isSelected ? HSColor.green06 : HSColor.neutral6))
            ],
          ),
        ),
      );
}
