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
  void _onItemTapped(int index) {
    _selectedIndex.value = index;
  }

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
              // TODO add notification icon
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
                        icon: Assets.icons.explore, // TODO use booking icon without dot
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
                        icon: Assets.icons.explore, // TODO use message icon without dot
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

  double _calculateToolbarHeight(
      {required String title,
      required TextStyle? textStyle,
      required double textScaleFactor}) {
    TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: title,
          style: textStyle,
        ),
        textScaleFactor: textScaleFactor,
        textDirection: TextDirection.ltr)
      ..layout();

    final double titleHeight = textPainter.height;
    final double searchHeight = 0;

    final height = 24 /* padding top */
        +
        titleHeight +
        24 /* padding bottom */
        +
        searchHeight;

    return height;
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
        radius: 60,
        onTap: onTap,
        child: AspectRatio(
          aspectRatio: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
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
        ),
      );
}
